import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:iop_sdk/entities.dart';
import 'package:iop_wallet/src/pages/actions/add_credential.dart';
import 'package:iop_wallet/src/pages/authority/authority_processes.dart';
import 'package:iop_wallet/src/pages/home/home.dart';
import 'package:iop_wallet/src/pages/onboarding/create_vault.dart';
import 'package:iop_wallet/src/pages/onboarding/restore_vault.dart';
import 'package:iop_wallet/src/pages/onboarding/welcome_new_user.dart';
import 'package:iop_wallet/src/pages/profiles/profiles.dart';
import 'package:iop_wallet/src/pages/settings/show_mnemonic.dart';
import 'package:iop_wallet/src/pages/settings/settings.dart';
import 'package:iop_wallet/src/pages/wallet/wallet_page.dart';
import 'package:iop_wallet/src/pages/welcome/welcome.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:iop_wallet/src/utils.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  late Widget page;
  final args = settings.arguments;

  if (settings.name == routeHome) {
    page = HomePage();
  } else if (settings.name == routeWelcome) {
    page = WelcomePage();
  } else if (settings.name == routeAddCredential) {
    page = AddCredentialPage();
  } else if (settings.name == routeAuthorityProcesses) {
    if (args is AuthorityUrlArguments) {
      page =
          AuthorityProcessesPage(authorityUrl: ApiConfig(args.host, args.port));
    }
  } else if (settings.name == routeProfiles) {
    page = ProfilesPage();
  } else if (settings.name == routeSettings) {
    page = SettingsPage();
  } else if (settings.name == routeShowMnemonic) {
    page = ShowMnemonicPage();
  } else if (settings.name == routeVault) {
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
      case routeSetupCreateVault:
        page = CreateVault();
        break;
      case routeSetupRestoreVault:
        page = RestoreVault();
        break;
      default:
        page = WelcomeNewUser();
    }

    return MaterialPageRoute(builder: (context) => page, settings: settings);
  }
}
