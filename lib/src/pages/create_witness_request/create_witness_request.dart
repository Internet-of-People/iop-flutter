import 'package:flutter/material.dart';
import 'package:json_schema2/json_schema2.dart';
import 'package:provider/provider.dart';

import 'package:iop_sdk/authority.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:iop_wallet/src/models/credential/credential.dart';
import 'package:iop_wallet/src/models/wallet/wallet.dart';
import 'package:iop_wallet/src/widgets/warning_card.dart';
import 'package:iop_wallet/src/shared_prefs.dart';
import 'package:iop_wallet/src/utils/schema_form/form_builder.dart';
import 'package:iop_wallet/src/utils/schema_form/map_as_table.dart';

import 'widgets/navigation_container.dart';
import 'widgets/request_has_been_sent_dialog.dart';
import 'widgets/step_buttons.dart';

abstract class _Step {
  static const int claimSchema = 0;
  static const int evidenceSchema = 1;
  static const int confirmAndSign = 2;
}

class CreateWitnessRequestArgs {
  final String processName;
  final ContentId processContentId;
  final JsonSchema claimSchema;
  final JsonSchema? evidenceSchema;
  final ApiConfig authorityConfig;

  CreateWitnessRequestArgs(
    this.processName,
    this.processContentId,
    this.claimSchema,
    this.evidenceSchema,
    this.authorityConfig,
  );
}

class CreateWitnessRequestPage extends StatefulWidget {
  final JsonSchemaFormTree _claimSchemaTree = JsonSchemaFormTree();
  final JsonSchemaFormTree _evidenceSchemaTree = JsonSchemaFormTree();
  final CreateWitnessRequestArgs _args;

  CreateWitnessRequestPage(
    this._args, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CreateWitnessRequestPageState();
  }
}

class CreateWitnessRequestPageState extends State<CreateWitnessRequestPage> {
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
  late SchemaDefinedFormContent? _evidenceForm;
  bool _signing = false;
  late bool _requiresEvidence;

  @override
  void initState() {
    super.initState();

    _requiresEvidence = widget._args.evidenceSchema != null;

    _claimForm = SchemaDefinedFormContent(
      widget._args.claimSchema,
      widget._claimSchemaTree,
    );

    if(_requiresEvidence) {
      _evidenceForm = SchemaDefinedFormContent(
        widget._args.evidenceSchema!,
        widget._evidenceSchemaTree,
      );
    }
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
                        child: _buildEvidenceForm(),
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
                      const Padding(
                        padding: EdgeInsets.only(top: 32.0),
                        child: WarningCard('''Are you sure, you would like to sign this data below and create a witness request?'''),
                      )
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
    if (_claimData == null || _evidenceData == null) {
      return;
    }

    final claimData = Content(DynamicContent(_claimData!, null, null), null);
    final evidenceData = _buildEvidenceData();

    final serializedVault = await AppSharedPrefs.getVault();
    final activePersona = await AppSharedPrefs.getActivePersona();
    final unlockPassword = await AppSharedPrefs.getUnlockPassword();

    final vault = Vault.load(serializedVault!);
    final morpheusPlugin = MorpheusPlugin.get(vault);
    final did = morpheusPlugin.public.personas.did(activePersona!);

    final request = WitnessRequest(
      Claim(DidData(did.toString()), claimData),
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

    final capabilityUrl =
        '${widget._args.authorityConfig.host}:${widget._args.authorityConfig.port}/request/${response.value}/status';

    final wallet = context.read<WalletModel>();
    await wallet.addCredential(Credential(
      widget._args.processContentId,
      widget._args.processName,
      DateTime.now().toIso8601String(),
      capabilityUrl,
      Status.pending,
      null,
      null,
    ));
    await wallet.save();

    setState(() {
      _signing = false;
    });

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => RequestHasBeenSentDialog(),
    );
  }

  Widget _buildStepperNavigation(
    BuildContext context, {
    void Function()? onStepCancel,
    void Function()? onStepContinue,
  }) {
    final buttons = <Widget>[];

    switch (_currentStep) {
      case _Step.claimSchema:
        buttons.add(StepContinueButton('Continue', onStepContinue));
        break;
      case _Step.evidenceSchema:
        buttons.add(StepContinueButton('Continue', onStepContinue));
        buttons.add(StepBackButton('Back', onStepCancel));
        break;
      case _Step.confirmAndSign:
        if (_signing) {
          buttons.add(const CircularProgressIndicator());
        } else {
          buttons.add(StepContinueButton('Sign & Send', _onSign));
          buttons.add(StepBackButton('back', onStepCancel));
        }
        break;
    }

    return NavigationContainer(buttons);
  }

  Widget _buildEvidenceForm() {
    if(_evidenceForm == null) {
      return const Text('No evidence is required.');
    }
    return _evidenceForm!;
  }

  Content<DynamicContent> _buildEvidenceData() {
    if(_evidenceData == null) {
      return Content(DynamicContent({}, null, null),null);
    }

    return Content(
      DynamicContent(_evidenceData!, null, null),
      null,
    );
  }
}
