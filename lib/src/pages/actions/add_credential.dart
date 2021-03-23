import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:iop_wallet/src/models/credential/credential.dart';
import 'package:iop_wallet/src/models/wallet/wallet.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AddCredentialPage extends StatelessWidget {
  final double boxWidth = 200;

  @override
  Widget build(BuildContext context) {
    final wallet = context.watch<WalletModel>();
    final nameEditingController = TextEditingController();
    final jsonController = TextEditingController();

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Add Credential')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: nameEditingController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.add),
                  labelText: 'Enter a Credential Title'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: jsonController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.note),
                labelText: 'Enter Details',
              ),
            ),
          ),
          SizedBox(
            width: boxWidth,
            child: ElevatedButton(
              onPressed: () {
                wallet.add(Credential.fromString(
                    '{"name": "${nameEditingController.text}", "details": ${jsonController.text}}'));
              },
              child: Text('Add Credential'),
            ),
          ),
          SizedBox(
            width: boxWidth,
            child: ElevatedButton(
              onPressed: () {
                wallet.add(Credential.fromString(
                    '{"name": "Hello", "details": {"name": "Hello", "details": "world"}}'));
              },
              child: Text('Add dummy Credential'),
            ),
          ),
          SizedBox(
            width: boxWidth,
            child: ElevatedButton(
                onPressed: () => scanQR(), child: Text('Scan QR-code')),
          )
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
