import 'package:flutter/material.dart';
import 'package:iop_sdk/inspector.dart';

class LicensePanel {
  static ExpansionPanel build(
    List<LicenseSpecification> licenses,
    bool expanded,
  ) {
    final details = licenses.map((l) {
      return Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text('Issued To: ${l.issuedTo}'),
              subtitle: Text('Purpose: ${l.purpose}, expiry: ${l.expiry}'),
              isThreeLine: true,
            ),
          )
        ],
      );
    }).toList();

    return ExpansionPanel(
      headerBuilder: (context, isExpanded) => const ListTile(
        title: Text('Required Licenses'),
        subtitle: Text('Who will access to your data?'),
      ),
      body: Column(children: details),
      isExpanded: expanded,
    );
  }
}
