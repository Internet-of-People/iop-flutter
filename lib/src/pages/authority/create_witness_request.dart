import 'package:flutter/material.dart';
import 'package:iop_wallet/src/models/credential/credential.dart';
import 'package:iop_wallet/src/models/wallet/wallet.dart';
import 'package:provider/provider.dart';
import 'package:iop_sdk/authority.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:iop_wallet/src/shared_prefs.dart';
import 'package:iop_wallet/src/utils/schema_form/form_builder.dart';
import 'package:iop_wallet/src/utils/schema_form/map_as_table.dart';
import 'package:json_schema2/json_schema2.dart';

abstract class _Step {
  static const int claimSchema = 0;
  static const int evidenceSchema = 1;
  static const int confirmAndSign = 2;
}

class CreateWitnessRequestArgs {
  final String processName;
  final ContentId processContentId;
  final JsonSchema claimSchema;
  final JsonSchema evidenceSchema;
  final ApiConfig authorityConfig;

  CreateWitnessRequestArgs(
    this.processName,
    this.processContentId,
    this.claimSchema,
    this.evidenceSchema,
    this.authorityConfig,
  );
}

class CreateWitnessRequest extends StatefulWidget {
  final JsonSchemaFormTree _claimSchemaTree = JsonSchemaFormTree();
  final JsonSchemaFormTree _evidenceSchemaTree = JsonSchemaFormTree();
  final CreateWitnessRequestArgs _args;

  CreateWitnessRequest(
    this._args, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CreateWitnessRequestState();
  }
}

class CreateWitnessRequestState extends State<CreateWitnessRequest> {
  final GlobalKey<FormState> _claimFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _evidenceFormKey = GlobalKey<FormState>();
  final List<StepState> _stepStates = [
    StepState.indexed,
    StepState.indexed,
    StepState.indexed,
  ];

  AutovalidateMode _claimFormAutoValidate = AutovalidateMode.disabled;
  AutovalidateMode _evidenceFormAutoValidate = AutovalidateMode.disabled;
  Map<String, dynamic>? _claimData;
  Map<String, dynamic>? _evidenceData;
  int _currentStep = _Step.claimSchema;
  late SchemaDefinedFormContent _claimForm;
  late SchemaDefinedFormContent _evidenceForm;
  bool _signing = false;

  @override
  void initState() {
    super.initState();

    _claimForm = SchemaDefinedFormContent(
      widget._args.claimSchema,
      widget._claimSchemaTree,
    );

    _evidenceForm = SchemaDefinedFormContent(
      widget._args.evidenceSchema,
      widget._evidenceSchemaTree,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget._args.processName),
        ),
        body: Stepper(
            currentStep: _currentStep,
            onStepContinue: _onStepContinue,
            onStepCancel: _onStepCancel,
            controlsBuilder: _buildStepperNavigation,
            steps: [
              Step(
                  title: const Text('Providing Personal Information'),
                  isActive: _currentStep == _Step.claimSchema,
                  state: _stepStates[_Step.claimSchema],
                  content: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _claimFormKey,
                        autovalidateMode: _claimFormAutoValidate,
                        child: _claimForm,
                      ),
                    ),
                  )),
              Step(
                  title: const Text('Providing Evidence'),
                  isActive: _currentStep == _Step.evidenceSchema,
                  state: _stepStates[_Step.evidenceSchema],
                  content: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _evidenceFormKey,
                        autovalidateMode: _evidenceFormAutoValidate,
                        child: _evidenceForm,
                      ),
                    ),
                  )),
              Step(
                  title: const Text('Confirm'),
                  subtitle: const Text('Please confirm sign'),
                  isActive: _currentStep == _Step.confirmAndSign,
                  state: _stepStates[_Step.confirmAndSign],
                  content: Column(
                    children: <Widget>[
                      MapAsTable(_claimData, 'Personal Information'),
                      MapAsTable(_evidenceData, 'Evidence'),
                      Card(
                          child: Container(
                        margin: const EdgeInsets.all(16.0),
                        child: Row(children: [
                          Container(
                            margin: const EdgeInsets.only(right: 16.0),
                            child: const Icon(
                              Icons.warning,
                              color: Colors.deepOrange,
                            ),
                          ),
                          const Expanded(
                              child: Text(
                            'Are you sure, you would like to sign this data below and create a witness request?',
                          ))
                        ]),
                      )),
                    ],
                  )),
            ]));
  }

  void _onStepContinue() {
    if (_currentStep == _Step.claimSchema) {
      if (!_claimFormKey.currentState!.validate()) {
        setState(() {
          _stepStates[_Step.claimSchema] = StepState.error;
          _claimFormAutoValidate = AutovalidateMode.always;
        });
        return;
      }

      setState(() {
        _claimData = widget._claimSchemaTree.asMapWithValues();
        _stepStates[_Step.claimSchema] = StepState.complete;
        _currentStep++;
      });
    } else if (_currentStep == _Step.evidenceSchema) {
      if (!_evidenceFormKey.currentState!.validate()) {
        setState(() {
          _stepStates[_Step.evidenceSchema] = StepState.error;
          _evidenceFormAutoValidate = AutovalidateMode.always;
        });
        return;
      }

      setState(() {
        _evidenceData = widget._evidenceSchemaTree.asMapWithValues();
        _stepStates[_Step.evidenceSchema] = StepState.complete;
        _currentStep++;
      });
    }
  }

  void _onStepCancel() {
    if (_currentStep > _Step.claimSchema) {
      setState(() => _currentStep = _currentStep - 1);
    }
  }

  Future<void> _onSign() async {
    if(_claimData == null || _evidenceData == null) {
      return;
    }

    final claimData = Content(DynamicContent(_claimData!, null, null), null);
    final evidenceData =
        Content(DynamicContent(_evidenceData!, null, null), null);

    final serializedVault = await AppSharedPrefs.getVault();
    final activePersona = await AppSharedPrefs.getActivePersona();
    final unlockPassword = await AppSharedPrefs.getUnlockPassword();

    final vault = Vault.load(serializedVault!);
    final morpheusPlugin = MorpheusPlugin.get(vault);
    final did = morpheusPlugin.public.personas.did(activePersona!);

    final claim = Claim(DidData(did.toString()), claimData);

    final request = WitnessRequest(
      claim,
      KeyLink('${did.toString()}#0'),
      widget._args.processContentId,
      evidenceData,
      nonce264(),
    );

    setState(() {
      _signing = true;
    });

    final morpheusPrivate = morpheusPlugin.private(unlockPassword!);
    final signedRequest = morpheusPrivate.signWitnessRequest(
      did.defaultKeyId(),
      request,
    );

    final authorityApi = AuthorityPublicApi(widget._args.authorityConfig);
    final response = await authorityApi.sendRequest(signedRequest);

    final capabilityUrl = '${widget._args.authorityConfig.host}:${widget._args.authorityConfig.port}/request/${response.value}/status';

    final wallet = context.read<WalletModel>();
    wallet.addCredential(Credential(
      DateTime.now().toIso8601String(),
      widget._args.processName,
      capabilityUrl,
      Status.pending,
      null,
      null
    ));
    await wallet.save();

    setState(() {
      _signing = false;
    });

    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Row(
                children: const <Widget>[Text('Sent')],
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const<Widget>[Text('Your request has been sent.')],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () async {
                    await Navigator.pushNamed(
                      context,
                      routeWelcome,
                    );
                  },
                  child: const Text('BACK TO HOME'),
                ),
              ],
            ));
  }

  Widget _buildStepperNavigation(
    BuildContext context, {
    void Function()? onStepCancel,
    void Function()? onStepContinue,
  }) {
    final themeData = Theme.of(context);
    final cancelButton = Container(
      margin: const EdgeInsetsDirectional.only(start: 8.0),
      child: FlatButton(
        onPressed: onStepCancel,
        textColor: Colors.black54,
        textTheme: ButtonTextTheme.normal,
        child: const Text('BACK'),
      ),
    );
    final continueButton = FlatButton(
      onPressed: onStepContinue,
      color: themeData.primaryColor,
      textColor: Colors.white,
      textTheme: ButtonTextTheme.normal,
      child: const Text('CONTINUE'),
    );
    final signButton = FlatButton(
      onPressed: () => _onSign(),
      color: themeData.primaryColor,
      textColor: Colors.white,
      textTheme: ButtonTextTheme.normal,
      child: const Text('SIGN & SEND'),
    );

    final buttons = <Widget>[];

    switch (_currentStep) {
      case _Step.claimSchema:
        buttons.add(continueButton);
        break;
      case _Step.evidenceSchema:
        buttons.add(continueButton);
        buttons.add(cancelButton);
        break;
      case _Step.confirmAndSign:
        if (_signing) {
          buttons.add(const CircularProgressIndicator());
        } else {
          buttons.add(signButton);
          buttons.add(cancelButton);
        }
        break;
    }

    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 48.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: buttons),
      ),
    );
  }
}
