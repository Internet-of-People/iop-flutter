import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:iop_wallet/src/theme.dart';

const double buttonWidth = 100;

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

// TODO: This is only used in showMnemonicPage (settings).
//  Might be deleted in the future.
List<TableRow> createMnemonicTable(List<String> mnemonicList) {
  final mnemonicTable = <TableRow>[];
  var tableRow = <Widget>[];

  for (var i = 0; i < mnemonicList.length; i++) {
    final tile = createListTile(i, mnemonicList[i]);
    tableRow.add(tile);

    if (tableRow.length == 4) {
      mnemonicTable.add(TableRow(children: tableRow));
      tableRow = [];
    }
  }
  return mnemonicTable;
}

// TODO: This is now only used in the function above.
//  This might be deleted in the future.
Widget createListTile(int index, String content) {
  return ListTile(
    dense: true,
    minLeadingWidth: 1,
    horizontalTitleGap: 4,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14),
    title: Text(
      '${index + 1}: $content',
      style: textTheme.bodyText2,
    ),
  );
}

// TODO: remove this formatted icon which does something with formatting.
Icon formattedIcon(IconData iconData) =>
    Icon(iconData, size: 250, color: appTheme.primaryColor);

Widget buildStyledTextButton(String label, IconData iconData) => SizedBox(
      width: 120,
      child: TextButton.icon(
        style: TextButton.styleFrom(backgroundColor: appTheme.backgroundColor),
        label: Text(label, style: TextStyle(color: appTheme.primaryColor)),
        icon: Icon(iconData, color: appTheme.primaryColor),
        onPressed: () {},
      ),
    );
