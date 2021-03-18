import 'package:flutter/foundation.dart';

import '../shared_prefs.dart';
import 'credential.dart';

class WalletModel extends ChangeNotifier {
  List<CredentialModel> _credentials = [];
  List<CredentialModel?> get credentials => _credentials;

  bool _isWaiting = true;
  bool _hasError = false;

  bool get isWaiting => _isWaiting;
  bool get hasError => _hasError;

  add(CredentialModel credential) async {
    await _updateStorageAndNotifyAfter(() {
      _credentials.add(credential);
    });
  }

  remove(CredentialModel? credential) async {
    await _updateStorageAndNotifyAfter(() {
      _credentials.remove(credential);
    });
  }

  Future load() async {
    _isWaiting = true;
    final credentialsString = await AppSharedPrefs.loadWallet();
    _credentials = credentialsString
        .map((str) => CredentialModel.fromString(str))
        .toList();
    notifyListeners();
    _isWaiting = false;
  }

  _updateStorageAndNotifyAfter(Function function) async {
    try {
      function.call();
      await _saveWallet();
      notifyListeners();
      _hasError = false;
    } catch (e) {
      _hasError = true;
    }
  }

  _saveWallet() async {
    _isWaiting = true;
    await AppSharedPrefs.setWallet(_credentials);
    _isWaiting = false;
  }

  emptyStorage() async {
    _isWaiting = true;
    await AppSharedPrefs.setWallet([]);
    _isWaiting = false;
  }
}
