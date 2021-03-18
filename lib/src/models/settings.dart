import 'package:flutter/material.dart';
import 'package:iop_wallet/src/shared_prefs.dart';

class SettingsModel extends ChangeNotifier {
  Future<bool> _initialized = Future(() {
    return false;
  });
  Future<bool> get initialized => _initialized;

  Future<void> setInitialized(bool initializationCompleted) async {
    await AppSharedPrefs.setInitialized(initializationCompleted);
    _initialized = Future(() => initializationCompleted);
    notifyListeners();
  }
}
