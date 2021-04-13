import 'package:flutter/material.dart';
import 'package:iop_wallet/src/utils/scenario_requirement.dart';

class PrerequisitesPanel {
  static ExpansionPanel build(
    ScenarioRequirement requirement,
    bool expanded,
  ) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) => const ListTile(
        title: Text('Prerequisites'),
        subtitle: Text('What data you must provide?'),
      ),
      body: _build(requirement),
      isExpanded: expanded,
    );
  }

  static Widget _build(ScenarioRequirement requirement) {
    final details = <Widget>[];

    for(final item in requirement.items) {
      details.add(ListTile(
          title: Text('Process: ${item.process.name}'),
          subtitle: Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              item.prerequisite.claimFields.map((e) => '- $e').join('\n'),
            ),
          )));
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(children: details),
    );
  }
}
