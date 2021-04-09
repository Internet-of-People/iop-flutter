import 'package:flutter/material.dart';
import 'package:iop_sdk/entities.dart';
import 'package:iop_wallet/src/models/credential/credential.dart';
import 'package:iop_wallet/src/pages/authority_process_details/authority_process_details.dart';
import 'package:iop_wallet/src/pages/authority_processes/authority_processes.dart';
import 'package:iop_wallet/src/pages/create_witness_request/create_witness_request.dart';
import 'package:iop_wallet/src/pages/home/home.dart';
import 'package:iop_wallet/src/pages/home/tabs/credentials/credential_details.dart';
import 'package:iop_wallet/src/pages/onboarding/create_vault.dart';
import 'package:iop_wallet/src/pages/personas/personas.dart';
import 'package:iop_wallet/src/pages/settings/settings.dart';
import 'package:iop_wallet/src/pages/welcome/welcome.dart';
import 'package:iop_wallet/src/router_constants.dart';

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
    if (args is ApiConfig) {
      page = AuthorityProcessesPage(args);
    }
  }
  else if (settings.name == routeCredentialDetails) {
    if (args is Credential) {
      page = CredentialDetails(args);
    }
  }
  else if (settings.name == routeAuthorityProcessDetails) {
    if (args is AuthorityProcessDetailsArgs) {
      page = AuthorityProcessDetailsPage(args);
    }
  }
  else if(settings.name == routeAuthorityCreateWitnessRequest) {
    if(args is CreateWitnessRequestArgs) {
      page = CreateWitnessRequestPage(args);
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
