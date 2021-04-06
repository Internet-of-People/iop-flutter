import 'package:flutter/material.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_wallet/src/pages/authority/authority_processes.dart';
import 'package:iop_wallet/src/pages/home/home.dart';
import 'package:iop_wallet/src/pages/onboarding/create_vault.dart';
import 'package:iop_wallet/src/pages/personas/personas.dart';
import 'package:iop_wallet/src/pages/settings/settings.dart';
import 'package:iop_wallet/src/pages/welcome/welcome.dart';
import 'package:iop_wallet/src/router_constants.dart';
import 'package:iop_wallet/src/utils.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  late Widget page;
  final args = settings.arguments;

  if (settings.name == routeHome) {
    page = HomePage();
  }
  else if (settings.name == routeWelcome) {
    page = WelcomePage();
  }
  else if (settings.name == routeSetupCreateVault) {
    page = CreateVault();
  }
  else if (settings.name == routeAuthorityProcesses) {
    if (args is AuthorityUrlArguments) {
      page =
          AuthorityProcessesPage(authorityUrl: ApiConfig(args.host, args.port));
    }
  }
  else if (settings.name == routePersonas) {
    page = PersonasPage();
  } else if (settings.name == routeSettings) {
    page = SettingsPage();
  } else {
    throw Exception('Unknown route: ${settings.name}');
  }

  return MaterialPageRoute(builder: (context) => page, settings: settings);
}

