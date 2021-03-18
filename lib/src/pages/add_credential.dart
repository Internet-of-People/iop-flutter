import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iop_wallet/src/models/credential.dart';
import 'package:iop_wallet/src/models/wallet.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
export 'add_credential.dart';

class Scanner extends StatelessWidget {
  final double boxWidth = 200;

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
              child: Text('Add Credential'),
              onPressed: () {
                _addCredential(context);
              }),
        ],
      ),
    );
  }

  void _addCredential(BuildContext context) {
    final wallet = context.read<WalletModel>();
    final nameEditingController = TextEditingController();
    final jsonController = TextEditingController();

    Navigator.push(context, MaterialPageRoute<void>(
      builder: (BuildContext context) {
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
                    child: Text('Add Credential'),
                    onPressed: () {
                      wallet.add(CredentialModel.fromString(
                          '{"name": "${nameEditingController.text}", "details": ${jsonController.text}}'));
                    },
                  ),
                ),
                SizedBox(
                  width: boxWidth,
                  child: ElevatedButton(
                    child: Text('Add dummy Credential'),
                    onPressed: () {
                      wallet.add(CredentialModel.fromString(
                          '{"name": "Hello", "details": {"name": "Hello", "details": "world"}}'));
                    },
                  ),
                ),
                SizedBox(
                  width: boxWidth,
                  child: ElevatedButton(
                      onPressed: () => scanQR(), child: Text('Scan QR-code')),
                )
              ],
            ));
      },
    ));
  }

  Future<void> scanQR() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.QR);
    print(barcodeScanRes);
  }
}
