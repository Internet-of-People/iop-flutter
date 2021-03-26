import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

final double buttonWidth = 100;

class AuthorityUrlArguments {
  AuthorityUrlArguments({required this.host, required this.port});

  final String host;
  final int port;
}

Future<String> scanQrUntilResult() async {
  final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', 'Cancel', true, ScanMode.QR);
  return barcodeScanRes;
}

List<TableRow> createMnemonicTable(List<String> mnemonicList) {
  final mnemonicTable = <TableRow>[];
  var tableRow = <Widget>[];

  for (var i = 0; i < mnemonicList.length; i++) {
    Widget tile = createListTile(i, mnemonicList[i]);
    tableRow.add(tile);

    if (tableRow.length == 4) {
      mnemonicTable.add(TableRow(children: tableRow));
      tableRow = [];
    }
  }
  return mnemonicTable;
}

ListTile createListTile(int index, String content) {
  final style = TextStyle(fontSize: 12, color: Colors.white);
  return ListTile(
    dense: true,
    minLeadingWidth: 1,
    horizontalTitleGap: 4,
    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    leading: Text(
      '${index + 1}.',
      style: style,
    ),
    title: Text(
      content,
      style: style,
    ),
  );
}
