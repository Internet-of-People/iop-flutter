import 'package:flutter/material.dart';
import 'package:iop_wallet/src/pages/create_vault.dart';
import 'package:iop_wallet/src/pages/enter_password.dart';
import 'package:iop_wallet/src/pages/home.dart';
import 'package:iop_wallet/src/pages/restore_vault.dart';
import 'package:iop_wallet/src/pages/settings.dart';
import 'package:iop_wallet/src/pages/setup.dart';
import 'package:iop_wallet/src/pages/welcome.dart';
import 'package:iop_wallet/src/router_constants.dart';

import 'pages/wallet_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  late Widget page;
  if (settings.name == routeHome) {
    page = HomePage();
  } else if (settings.name == routeWelcome) {
    page = WelcomePage();
  } else if (settings.name == routeSettings) {
    page = SettingsPage();
  } else if (settings.name == routeWallet) {
    page = WalletPage();
  } else if (settings.name!.startsWith(routePrefixSetup)) {
    page = SetupNavigator();
  } else {
    throw Exception('Unknown route: ${settings.name}');
  }

  return MaterialPageRoute(builder: (context) => page, settings: settings);
}

class SetupNavigator extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      initialRoute: routeSetupStart,
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case routeSetupStart:
        page = SetupPage();
        break;
      case routeSetupCreateVault:
        page = CreateVaultPage();
        break;
      case routeSetupEnterPassword:
        page = EnterPasswordPage();
        break;
      case routeSetupRestoreVault:
        page = RestoreVaultPage();
        break;
      default:
        page = SetupPage();
    }

    return MaterialPageRoute(builder: (context) => page, settings: settings);
  }
}
