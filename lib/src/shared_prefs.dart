import 'package:iop_wallet/src/models/credential/credential2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/credential/credential.dart';

class AppSharedPrefs {
  static const _serializedVaultKey = 'vault';
  static const _activePersonaKey = 'active_persona';
  static const _credentialPrefsKey = 'credentials';

  static Future<void> setVault(String serializedVault) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_serializedVaultKey, serializedVault);
    await setActivePersona(0);
  }

  static Future<String?> getVault() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_serializedVaultKey);
  }

  static Future<void> removeVault() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_serializedVaultKey);
    await prefs.remove(_activePersonaKey);
  }

  static Future<void> setActivePersona(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_activePersonaKey, index);
  }

  static Future<int?> getActivePersona() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_activePersonaKey);
  }

  static Future<void> addSignedStatement() async {
    final prefs = await SharedPreferences.getInstance();
    final credentials = prefs.getString(_credentialPrefsKey);
    // TODO: parse credentials, addo the array, save back
  }

  static Future<List<Credential2>> getCredentials() async {
    // TODO
    return [];
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
