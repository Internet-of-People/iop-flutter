import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:iop_wallet/src/utils.dart';

class ActionPage extends StatelessWidget {
  final double boxWidth = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: _getOptions(context)));
  }

  Widget _getOptions(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('lib/src/assets/iop_logo.png'),
            width: 200,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, routeAuthorityProcesses,
                  arguments: AuthorityUrlArguments(
                      host: 'http://10.0.2.2', port: 8083));
            },
            child: SizedBox(
                width: boxWidth, child: Center(child: Text('Scan QR'))),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, routeAddCredential),
            child: SizedBox(
                width: boxWidth, child: Center(child: Text('Add Credential'))),
          ),
        ],
      ),
    );
  }

  Future<void> scanQR() async {
    final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR);
    print(barcodeScanRes);
  }
}
