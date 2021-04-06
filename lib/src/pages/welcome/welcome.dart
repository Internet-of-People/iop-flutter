import 'package:flutter/material.dart';
import 'package:iop_wallet/src/pages/home/home.dart';
import 'package:iop_wallet/src/pages/onboarding/welcome_new_user.dart';
import 'package:iop_wallet/src/shared_prefs.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late Future<bool> _isVaultSetupFut;

  @override
  void initState() {
    super.initState();
    _isVaultSetupFut = _doesVaultExist();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _isVaultSetupFut,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == true) {
            return HomePage();
          } else {
            return WelcomeNewUser();
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<bool> _doesVaultExist() async {
    final vault = await AppSharedPrefs.getVault();
    return vault != null;
  }
}
