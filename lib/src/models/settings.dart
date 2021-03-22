import 'package:flutter/material.dart';
import 'package:iop_wallet/src/shared_prefs.dart';

class SettingsModel extends ChangeNotifier {
  Future<bool> initialized = Future(() {
    return false;
  });

  Future<void> setInitialized(bool initializationCompleted) async {
    await AppSharedPrefs.setInitialized(initializationCompleted);
    initialized = Future(() => initializationCompleted);
    notifyListeners();
  }
}
