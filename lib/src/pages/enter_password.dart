import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iop_wallet/src/models/settings.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:iop_wallet/src/utils.dart';

class EnterPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsModel>();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Choose your unlock password'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: buttonWidth,
                child: ElevatedButton(
                  onPressed: () async {
                    await settings.setInitialized(true);
                    await Navigator.pushNamedAndRemoveUntil(
                        context, routeWelcome, (Route<dynamic> route) => false);
                  },
                  child: Text('Finish'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
