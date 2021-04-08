import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iop_wallet/src/nullable_text.dart';

class MapAsTable extends StatelessWidget {
  final Map<String, dynamic> _map;
  final String _title;

  const MapAsTable(this._map, this._title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final table = _buildTable(_title, _map, true, context);
    if (table != null) {
      return Column(children: [table]);
    }

    return const Text('NO DATA PROVIDED');
  }

  Widget? _buildTable(
    String? title,
    Map<String, dynamic>? data,
    bool topLevel,
    BuildContext context,
  ) {
    if (data == null) {
      return null;
    }

    if (topLevel) {
      const columns = <DataColumn>[
        DataColumn(label: Text('Key')),
        DataColumn(label: Text('Value'))
      ];
      final rows = _mapToRow(data, null, context);

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: <Widget>[
            Row(children: [
              Expanded(
                  child: NullableText(
                text: toBeginningOfSentenceCase(title),
                style: Theme.of(context).textTheme.subtitle1,
              ))
            ]),
            Row(children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Hint: Click on the text to get more detail',
                        style: Theme.of(context).textTheme.caption,
                      )))
            ]),
            Row(children: [
              Expanded(
                  child: DataTable(
                columns: columns,
                rows: rows,
              ))
            ])
          ],
        ),
      );
    }

    return null;
  }

  List<DataRow> _mapToRow(
    Map<String, dynamic> map,
    String? parent,
    BuildContext context,
  ) {
    final rows = <DataRow>[];

    for (final entry in map.entries) {
      final cells = <DataCell>[];

      if (entry.value is Map) {
        final thisLevel = parent == null ? entry.key : '$parent / ${entry.key}';
        rows.addAll(
            _mapToRow(entry.value as Map<String, dynamic>, thisLevel, context));
      } else {
        cells.add(DataCell(Text(parent == null ? entry.key : entry.key),
            onTap: () async {
          await showDialog(
              context: context,
              builder: (_) => SimpleDialog(
                    children: [
                      SimpleDialogOption(
                        child: Text(parent == null
                            ? entry.key
                            : '$parent / ${entry.key}'),
                      ),
                    ],
                  ));
        }));

        // TODO currently we expect photo values' keys to be started with 'photo'
        // TODO we also expect that photos are base64 encoded
        if (entry.key.startsWith('photo')) {
          cells.add(DataCell(entry.value == null
              ? const Text('null')
              : Image.memory(base64Decode(entry.value.toString()))));
        } else {
          var text = 'Unknown entry value';
          if (entry.value == null) {
            text = 'null';
          } else if (entry.value is String) {
            text = entry.value as String;
          } else if (entry.value is int) {
            text = (entry.value as int).toString();
          } else if (entry.value is DateTime) {
            text = (entry.value as DateTime).toIso8601String();
          }

          final cutText =
              text.length > 26 ? '${text.substring(0, 26)}...' : text;

          cells.add(DataCell(Text(cutText), onTap: () async {
            await showDialog(
                context: context,
                builder: (_) => SimpleDialog(
                      children: [
                        SimpleDialogOption(
                          child: Text(text),
                        ),
                      ],
                    ));
          }));
        }

        rows.add(DataRow(cells: cells));
      }
    }

    return rows;
  }
}
