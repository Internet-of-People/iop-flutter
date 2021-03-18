import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QrScanner extends StatelessWidget {
  late final String? scanResult;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future scanBarcodeNormal() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.QR);
    print(barcodeScanRes);
    setState(barcodeScanRes);
  }

  setState(String result) {
    scanResult = result;
  }
}
