import 'package:iop_wallet/src/models/credential/credential.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefs {
  static const _serializedVaultKey = 'vault';
  static const _activePersonaKey = 'active_persona';
  static const _walletKey = 'wallet';

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

  static Future<void> setWallet(String serializedWallet) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_walletKey, serializedWallet);
  }

  static Future<String?> loadWallet() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_walletKey);
  }
}
