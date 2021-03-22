import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QrScanner extends StatefulWidget {
  @override
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  late final String? scanResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text((scanResult == null) || (scanResult == '')
            ? 'Please scan to show some result'
            : 'Result:' + scanResult.toString()),
      ),
    );
  }

  Future scanBarcodeNormal() async {
    final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR);
    print(barcodeScanRes);
    setState(() => scanResult = barcodeScanRes);
  }
}
