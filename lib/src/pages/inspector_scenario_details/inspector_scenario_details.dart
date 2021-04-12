import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_wallet/src/models/wallet/wallet.dart';
import 'package:iop_wallet/src/utils/scenario_requirement.dart';
import 'package:provider/provider.dart';
import 'package:iop_sdk/authority.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/inspector.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:iop_wallet/src/pages/inspector_scenarios/widgets/license_panel.dart';
import 'package:iop_wallet/src/pages/inspector_scenarios/widgets/prerequisites_panel.dart';
import 'package:iop_wallet/src/pages/inspector_scenarios/widgets/result_panel.dart';
import 'package:iop_wallet/src/widgets/description_column.dart';
import 'package:iop_wallet/src/widgets/version_column.dart';

import 'widgets/data_available.dart';
import 'widgets/no_data_available.dart';

class InspectorScenarioDetailsPageArgs {
  final ApiConfig inspectorCfg;
  final Scenario scenario;

  InspectorScenarioDetailsPageArgs(this.inspectorCfg, this.scenario);
}

class InspectorScenarioDetailsPage extends StatefulWidget {
  final InspectorScenarioDetailsPageArgs _args;

  const InspectorScenarioDetailsPage(
    this._args, {
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InspectorScenarioDetailsPageState();
}

class _InspectorScenarioDetailsPageState
    extends State<InspectorScenarioDetailsPage> {
  int? _activePanel;

  late Future<ScenarioRequirement> _scenarioRequirementFut;

  @override
  void initState() {
    super.initState();
    _scenarioRequirementFut = _collectScenarioRequirement();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget._args.scenario.name),
        ),
        body: FutureBuilder(
          future: _scenarioRequirementFut,
          builder: (
            BuildContext context,
            AsyncSnapshot<ScenarioRequirement> snapshot,
          ) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  DescriptionColumn(widget._args.scenario.description),
                  VersionColumn(widget._args.scenario.version),
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    child: ExpansionPanelList(
                      expansionCallback: (index, isExpanded) {
                        setState(
                            () => _activePanel = isExpanded ? null : index);
                      },
                      children: [
                        PrerequisitesPanel.build(
                          snapshot.data!,
                          _activePanel == _Panel.prerequisites.index,
                        ),
                        LicensePanel.build(
                          widget._args.scenario.requiredLicenses,
                          _activePanel == _Panel.requiredLicenses.index,
                        ),
                        ResultPanel.build(
                          widget._args.scenario.resultSchema,
                          widget._args.inspectorCfg,
                          _activePanel == _Panel.result.index,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    child: _buildDataAvailableBlock(snapshot.data!),
                  )
                ],
              ),
            );
          },
        ));
  }

  Widget _buildDataAvailableBlock(ScenarioRequirement requirement) {
    return requirement.conditionsMeet()
        ? DataAvailableAlert(
            widget._args.scenario,
            requirement,
            widget._args.inspectorCfg,
          )
        : NoDataAvailableAlert();
  }

  Future<ScenarioRequirement> _collectScenarioRequirement() async {
    final processContents =
        widget._args.scenario.prerequisites.map((e) => e.process).toList();

    final api = InspectorPublicApi(widget._args.inspectorCfg);
    final processResolver = ContentResolver((contentId) async {
      final response = await api.getPublicBlob(contentId);
      return Process.fromJson(
        json.decode(response as String) as Map<String, dynamic>,
      );
    });

    final processes = await processResolver.resolveContents(processContents);

    final data = <ScenarioRequirementItem>[];
    for (var i = 0; i < processes.length; i++) {
      data.add(
        ScenarioRequirementItem(widget._args.scenario.prerequisites[i],
            processes[i], _getProcessCredential(digestJson(processes[i]))),
      );
    }

    return ScenarioRequirement(data);
  }

  Signed<WitnessStatement>? _getProcessCredential(ContentId processId) {
    final wallet = context.read<WalletModel>();

    for (final credential in wallet.credentials) {
      if (credential.status != Status.approved) {
        continue;
      }

      if (credential.processId.value == processId.value) {
        return credential.witnessStatement;
      }
    }

    return null;
  }
}

enum _Panel {
  prerequisites,
  requiredLicenses,
  result,
}

extension _PanelExt on _Panel {
  // ignore: unused_element
  int get index {
    switch (this) {
      case _Panel.prerequisites:
        return 0;
      case _Panel.requiredLicenses:
        return 1;
      case _Panel.result:
        return 2;
      default:
        throw Exception('Invalid Panel $this');
    }
  }
}
