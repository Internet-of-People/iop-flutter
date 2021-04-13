import 'package:flutter/material.dart';
import 'package:json_schema2/json_schema2.dart';
import 'package:iop_wallet/src/utils/nullable_text.dart';

class SchemaPanel {
  static ExpansionPanel build(
    JsonSchema? schema,
    String title,
    bool expanded,
  ) {
    if (schema == null) {
      return ExpansionPanel(
          headerBuilder: (context, isExpanded) => const ListTile(
                title: Text('Loading...'),
              ),
          body: Column(),
          isExpanded: expanded);
    }

    final widgets = <Widget>[];
    final requiredData = schema.requiredProperties == null
        ? '-'
        : schema.requiredProperties!.join(', ');

    widgets.add(
      Column(
        children: <Widget>[
          ListTile(
            title: const Text('Description'),
            subtitle: NullableText(text: schema.description),
          )
        ],
      ),
    );
    widgets.add(Column(
      children: <Widget>[
        ListTile(
            title: const Text('Required Data'),
            subtitle: NullableText(text: requiredData))
      ],
    ));

    return ExpansionPanel(
        headerBuilder: (context, isExpanded) => ListTile(title: Text(title)),
        body: Column(children: widgets),
        isExpanded: expanded);
  }
}
