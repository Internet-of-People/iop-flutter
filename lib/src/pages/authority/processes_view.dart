import 'package:flutter/material.dart';
import 'package:iop_wallet/src/models/process/process.dart';

class ProcessListView extends StatelessWidget {
  const ProcessListView(this._processes);

  final Map<String, Process> _processes;

  @override
  Widget build(BuildContext context) {
    final items = _buildItems(context);
    return ListView.builder(
        itemCount: _processes.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (_, index) => items[index]);
  }

  List<Column> _buildItems(context) {
    final columns = <Column>[];
    for (final entry in _processes.entries) {
      final process = entry.value;
      columns.add(Column(
        children: <Widget>[
          const Divider(height: 5.0),
          ListTile(
            title: Text(process.name),
            subtitle: Text(process.description),
          ),
        ],
      ));
    }
    return columns;
  }
}
