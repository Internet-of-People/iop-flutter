import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:iop_wallet/src/models/credential/credential.dart';
import 'package:iop_wallet/src/shared_prefs.dart';

class WalletModel extends ChangeNotifier {
  List<Credential> credentials = [];

  bool isWaiting = true;
  bool hasError = false;

  Future<void> add(Credential credential) async {
    await _updateStorageAndNotifyAfter(() {
      credentials.add(credential);
    });
  }

  Future<void> remove(Credential? credential) async {
    await _updateStorageAndNotifyAfter(() {
      credentials.remove(credential);
    });
  }

  Future load() async {
    isWaiting = true;
    final credentialsString = await AppSharedPrefs.loadWallet();
    credentials = credentialsString
        .map((str) => Credential.fromJson(jsonDecode(str)))
        .toList();
    notifyListeners();
    isWaiting = false;
  }

  Future<void> _updateStorageAndNotifyAfter(Function function) async {
    try {
      function.call();
      await _saveWallet();
      notifyListeners();
      hasError = false;
    } catch (e) {
      hasError = true;
    }
  }

  Future<void> _saveWallet() async {
    isWaiting = true;
    await AppSharedPrefs.setWallet(credentials);
    isWaiting = false;
  }

  Future<void> emptyStorage() async {
    isWaiting = true;
    await AppSharedPrefs.setWallet([]);
    isWaiting = false;
  }
}
