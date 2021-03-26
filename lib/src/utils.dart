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
