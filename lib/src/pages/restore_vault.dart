import 'package:flutter/material.dart';
import 'package:iop_wallet/src/pages/setup.dart';
import 'package:iop_wallet/src/router_constants.dart';

import '../utils.dart';

class RestoreVaultPage extends StatefulWidget {
  @override
  _RestoreVaultPageState createState() => _RestoreVaultPageState();
}

class _RestoreVaultPageState extends State<RestoreVaultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Unlock Your Wallet'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Enter your 24-word mnemonic to restore your wallet. Don't forget the spaces between the words and remember that the order of the words is important!"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                child: ElevatedButton(
                    child: Text('Continue'),
                    onPressed: () {
                      Navigator.pushNamed(context, routeSetupEnterPassword);
                    }),
                width: buttonWidth,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
