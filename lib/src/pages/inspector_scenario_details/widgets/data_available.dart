import 'package:flutter/material.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/inspector.dart';
import 'package:iop_wallet/src/pages/inspector_apply_scenario/inspector_apply_scenario.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:iop_wallet/src/utils/scenario_requirement.dart';

class DataAvailableAlert extends StatelessWidget {
  final Scenario _scenario;
  final ScenarioRequirement _requirement;
  final ApiConfig _inspectorCfg;

  const DataAvailableAlert(
    this._scenario,
    this._requirement,
    this._inspectorCfg, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(children: [
      Row(children: [
        Expanded(
          child: Icon(
            Icons.check_circle,
            size: 48,
            color: themeData.primaryColor,
          ),
        )
      ]),
      Row(children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 16, bottom: 16),
            child: const Text(
              'You have all the data available.',
              textAlign: TextAlign.center,
            ),
          ),
        )
      ]),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          onPressed: () async {
            await Navigator.of(context).pushNamed(
              routeInspectorApplyScenario,
              arguments: ApplyScenarioPageArgs(
                _scenario,
                _requirement,
                _inspectorCfg,
              ),
            );
          },
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: themeData.primaryColor,
          ),
          child: const Text(
            'Apply to this Scenario',
            style: TextStyle(fontSize: 14.0),
          ),
        ),
      )
    ]);
  }
}
