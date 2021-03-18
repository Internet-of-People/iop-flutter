import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iop_wallet/src/models/settings.dart';
import 'package:iop_wallet/src/pages/setup.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:iop_wallet/src/utils.dart';

class EnterPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var settings = context.watch<SettingsModel>();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Choose your unlock password"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(),
          ),
          Row(
            children: [
              SizedBox(
                child: ElevatedButton(
                    child: Text('Finish'),
                    onPressed: () async {
                      settings.setInitialized(true);
                      Navigator.pushNamedAndRemoveUntil(context, routeWelcome,
                          (Route<dynamic> route) => false);
                    }),
                width: buttonWidth,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ],
      ),
    );
  }
}
