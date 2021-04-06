import 'package:shared_preferences/shared_preferences.dart';

import 'models/credential/credential.dart';

class AppSharedPrefs {
  static const _serializedVaultKey = 'vault';
  static const _credentialPrefsKey = 'credentials';

  static Future<void> setVault(String serializedVault) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_serializedVaultKey, serializedVault);
  }

  static Future<String?> getVault() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_serializedVaultKey);
  }

  static Future<void> removeVault() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_serializedVaultKey);
  }

  // TODO: remove(?) these
  static Future<void> setWallet(List<Credential> credentials) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_credentialPrefsKey,
        credentials.map((credential) => credential.toString()).toList());
  }

  static Future<List<String>> loadWallet() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_credentialPrefsKey) ?? <String>[];
  }
}
