import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iop_wallet/src/router_constants.dart';
export 'action_page.dart';

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
              Navigator.pushNamed(context, routeScanner);
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
}
