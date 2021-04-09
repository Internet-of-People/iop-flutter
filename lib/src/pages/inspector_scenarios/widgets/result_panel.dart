import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_sdk/inspector.dart';
import 'package:iop_sdk/ssi.dart';
import 'package:json_schema2/json_schema2.dart';

class ResultPanel {
  static ExpansionPanel build(
    Content<DynamicContent>? resultSchema,
    ApiConfig inspectorCfg,
    bool expanded,
  ) {
    return ExpansionPanel(
      headerBuilder: (
        context,
        isExpanded,
      ) =>
          const ListTile(
        title: Text('Result'),
        subtitle: Text('What will you get?'),
      ),
      //body: _buildResult(resultSchema),
      body: FutureBuilder(
        future: _getResultSchemaFut(resultSchema, inspectorCfg),
        builder: (BuildContext context, AsyncSnapshot<JsonSchema?> snapshot) {
          if (snapshot.hasData) {
            final details = <Widget>[];

            if (snapshot.data == null) {
              return Column(children: const [Text('No data')]);
            }

            snapshot.data!.properties.forEach((key, value) {
              details.add(ListTile(
                title: Text(key),
                subtitle: Text(value.description!),
                isThreeLine: true,
              ));
            });

            return Column(children: details);
          }

          return Column(children: const [Text('Loading...')]);
        },
      ),
      isExpanded: expanded,
    );
  }

  static Future<JsonSchema?> _getResultSchemaFut(
    Content<DynamicContent>? resultSchema,
    ApiConfig inspectorCfg,
  ) async {
    if (resultSchema == null || resultSchema.contentId == null) {
      return null;
    }

    final resolver = ContentResolver((ContentId id) async {
      final resp = await InspectorPublicApi(inspectorCfg).getPublicBlob(id);
      return DynamicContent.fromJson(
        json.decode(resp as String) as Map<String, dynamic>,
      );
    });
    final resolved = await resolver.resolve(resultSchema);
    return JsonSchema.createSchema(resolved.content);
  }
}
