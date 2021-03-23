import 'package:shared_preferences/shared_preferences.dart';

import 'models/credential/credential.dart';

class AppSharedPrefs {
  static final _credentialPrefsKey = 'credentials';
  static final _initializedKey = 'initialized';

  static Future<void> setWallet(List<Credential> credentials) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_credentialPrefsKey,
        credentials.map((credential) => credential.toString()).toList());
  }

  static Future<List<String>> loadWallet() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_credentialPrefsKey) ?? <String>[];
  }

  static Future<void> setInitialized(bool initialized) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_initializedKey, initialized);
  }

  static Future<bool?> loadInitialized() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_initializedKey);
  }
}
