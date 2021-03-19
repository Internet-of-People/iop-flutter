import 'package:flutter/material.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:iop_wallet/src/utils.dart';

class RestoreVaultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Unlock Your Wallet'),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                "Enter your 24-word mnemonic to restore your wallet. Don't forget the spaces between the words and remember that the order of the words is important!"),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: buttonWidth,
                child: ElevatedButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, routeSetupEnterPassword);
                  },
                  child: Text('Continue'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
