import 'package:flutter/material.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/inspector.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:iop_wallet/src/pages/inspector_apply_scenario/widgets/information_header.dart';
import 'package:iop_wallet/src/pages/inspector_apply_scenario/widgets/presentation_qr.dart';
import 'package:iop_wallet/src/shared_prefs.dart';
import 'package:iop_wallet/src/utils/scenario_requirement.dart';
import 'package:iop_wallet/src/utils/schema_form/map_as_table.dart';
import 'package:json_resolver/json_resolver.dart';

class ApplyScenarioPageArgs {
  final Scenario scenario;
  final ScenarioRequirement requirement;
  final ApiConfig inspectorCfg;

  ApplyScenarioPageArgs(this.scenario, this.requirement, this.inspectorCfg);
}

class ApplyScenarioPage extends StatefulWidget {
  final ApplyScenarioPageArgs _args;

  const ApplyScenarioPage(
    this._args, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ApplyScenarioPageState();
}

class _ApplyScenarioPageState extends State<ApplyScenarioPage> {
  @override
  Widget build(BuildContext context) {
    final dataToBeShared = _getDataThatWillBeShared();
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget._args.scenario.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  InformationHeader(),
                  const Divider(),
                  MapAsTable(dataToBeShared, 'Data to be Shared'),
                  Column(
                    children: widget._args.scenario.requiredLicenses
                        .map((l) => MapAsTable(l.toJson(), 'License'))
                        .toList(),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 32.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: themeData.primaryColor,
                ),
                onPressed: _onShare,
                child: const Text(
                  'Confirm & Share',
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getDataThatWillBeShared() {
    final dataToBeShared = <String, dynamic>{};

    for (final item in widget._args.requirement.items) {
      for (final field in item.prerequisite.claimFields) {
        final f = field.startsWith('.') ? field.substring(1) : field;

        if (_claimContentIsAvailable(item)) {
          dataToBeShared[f] = resolve(
            json: item
                .statement!.content.content!.claim.content!.content.content!
                .toJson(),
            path: f,
          );
        }
      }
    }

    return dataToBeShared;
  }

  Future<void> _onShare() async {
    final provenClaims = <ProvenClaim>[];

    for (final item in widget._args.requirement.items) {
      final claimContent =
          item.statement!.content.content!.claim.content!.toJson();

      final maskedClaimContent = selectiveDigestJson(
        claimContent,
        item.prerequisite.claimFields.join(','),
      );

      final claim = Claim(
        item.statement!.content.content!.claim.content!.subject,
        Content(null, maskedClaimContent),
      );

      // IMPORTANT NOTE (to code analyzers): here, the SDK gives us the
      // opportunity to send multiple statements for one claim (meaning one
      // claim can be signed via multiple authorities). We can also send
      // multiple claims as well. In this application though we only use one
      // claim and one presentation.
      final statements = <Signed<WitnessStatement>>[
        Signed(
          item.statement!.signature,
          Content(null, digestJson(claimContent)),
        )
      ];
      provenClaims.add(ProvenClaim(claim, statements));
    }

    final licenses = widget._args.scenario.requiredLicenses
        .map((l) => _mapLicense(l))
        .toList();
    final presentation = Presentation(provenClaims, licenses, null);

    final serializedVault = await AppSharedPrefs.getVault();
    final activePersona = await AppSharedPrefs.getActivePersona();
    final unlockPassword = await AppSharedPrefs.getUnlockPassword();
    final vault = Vault.load(serializedVault!);
    final morpheusPlugin = MorpheusPlugin.get(vault);
    final morpheusPrivate = morpheusPlugin.private(unlockPassword!);
    final did = morpheusPlugin.public.personas.did(activePersona!);

    final signedPresentation = morpheusPrivate.signClaimPresentation(
      did.defaultKeyId(),
      presentation,
    );

    final inspectorApi = InspectorPublicApi(widget._args.inspectorCfg);
    final presentationId = await inspectorApi.uploadPresentation(
      signedPresentation,
    );
    final scenarioUrl = '${inspectorApi.baseUrl}/blob/${presentationId.value}';

    await showDialog(
      context: context,
      builder: (context) => PresentationQr(
        scenarioUrl,
        presentationId,
      ),
    );
  }

  License _mapLicense(LicenseSpecification licenseSpecification) {
    final now = DateTime.now();
    return License(
      licenseSpecification.issuedTo,
      licenseSpecification.purpose,
      now,
      now.add(const Duration(days: 1)), // TODO: convert the expiry field
    );
  }

  bool _claimContentIsAvailable(ScenarioRequirementItem item) {
    return item.statement?.content.content?.claim.content?.content.content !=
        null;
  }
}
