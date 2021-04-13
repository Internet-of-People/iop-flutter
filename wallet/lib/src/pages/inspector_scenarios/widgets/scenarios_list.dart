import 'package:flutter/material.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/inspector.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:iop_wallet/src/pages/inspector_scenario_details/inspector_scenario_details.dart';
import 'package:iop_wallet/src/router_constants.dart';

class ScenariosList extends StatelessWidget {
  final Map<ContentId, Scenario> _scenarios;
  final ApiConfig _inspectorCfg;

  const ScenariosList(
    this._inspectorCfg,
    this._scenarios, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = _buildItems(context);

    return ListView.builder(
        itemCount: _scenarios.length,
        padding: const EdgeInsets.all(15.0),
        itemBuilder: (_, index) => items[index]);
  }

  List<Column> _buildItems(BuildContext context) {
    final columns = <Column>[];
    for (final entry in _scenarios.entries) {
      final scenario = entry.value;
      columns.add(Column(
        children: <Widget>[
          const Divider(height: 5.0),
          ListTile(
            title: Text(scenario.name),
            subtitle: Text(scenario.description),
            onTap: () async {
              await Navigator.pushNamed(
                context,
                routeInspectorScenarioDetails,
                arguments: InspectorScenarioDetailsPageArgs(
                  _inspectorCfg,
                  scenario,
                ),
              );
            },
          ),
        ],
      ));
    }
    return columns;
  }
}
