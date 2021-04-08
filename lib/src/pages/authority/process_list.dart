import 'package:flutter/material.dart';
import 'package:iop_sdk/authority.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:iop_wallet/src/pages/authority/process_details.dart';
import 'package:iop_wallet/src/router_constants.dart';

class ProcessList extends StatelessWidget {
  const ProcessList(this._processes, this._cfg);

  final Map<ContentId, Process> _processes;
  final ApiConfig _cfg;

  @override
  Widget build(BuildContext context) {
    final items = _buildItems(context);
    return ListView.builder(
        itemCount: _processes.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (_, index) => items[index]);
  }

  List<Column> _buildItems(BuildContext context) {
    final columns = <Column>[];
    for (final entry in _processes.entries) {
      final contentId = entry.key;
      final process = entry.value;
      columns.add(Column(
        children: <Widget>[
          const Divider(height: 5.0),
          ListTile(
            title: Text(process.name),
            subtitle: Text(process.description),
            onTap: () async {
              await Navigator.pushNamed(
                context,
                routeAuthorityProcessDetails,
                arguments: ProcessDetailsArgs(contentId, process, _cfg),
              );
            },
          ),
        ],
      ));
    }
    return columns;
  }
}
