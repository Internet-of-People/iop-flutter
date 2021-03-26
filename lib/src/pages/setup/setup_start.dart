import 'package:flutter/material.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:iop_wallet/src/theme.dart';

class SetupPage extends StatelessWidget {
  final double boxWidth = 240;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage('lib/src/assets/iop_logo.png'),
              width: 400,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
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
                      Navigator.pushNamed(context, routeSetupCreateVault);
                    },
                    child: Text('Create a New Personal Vault'),
                  ),
                ),
                SizedBox(
                  width: boxWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, routeSetupRestoreVault);
                    },
                    child: Text('Restore an Existing Vault'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
