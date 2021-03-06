import 'package:flutter/material.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:iop_wallet/src/theme.dart';

class WelcomeNewUserPage extends StatelessWidget {
  final double boxWidth = 240;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Image(
              image: AssetImage('lib/src/assets/iop_logo.png'),
              width: 400,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Ready to take back your digital identity?',
                    style: textTheme.headline2),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width: boxWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, routeSetupCreateWallet);
                    },
                    child: const Text('Create a New Personal Wallet'),
                  ),
                ),
                // TODO: implement it, when restore path is done
                /*SizedBox(
                  width: boxWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, routeSetupRestoreWallet);
                    },
                    child: const Text('Restore an Existing Vault'),
                  ),
                ),*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}
