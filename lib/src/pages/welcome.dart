import 'package:flutter/material.dart';
import 'package:iop_wallet/src/models/settings.dart';
import 'package:iop_wallet/src/router.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:provider/provider.dart';
import 'home.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final initialized = context.select<SettingsModel, Future<bool>>(
        (settings) => settings.initialized);
    return FutureBuilder(
      future: initialized,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == true) {
            return HomePage();
          } else {
            return SetupNavigator();
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
