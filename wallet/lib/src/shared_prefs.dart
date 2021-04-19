import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefs {
  static const _serializedVaultKey = 'vault';
  // TODO: this might be required in the future
  // to be provided via a modal or something
  static const _unlockPasswordKey = 'unlock_password';
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

  static Future<void> removeWallet() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_serializedVaultKey);
    await prefs.remove(_activePersonaKey);
    await prefs.remove(_unlockPasswordKey);
    await prefs.remove(_walletKey);
  }

  static Future<void> setUnlockPassword(String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_unlockPasswordKey, password);
  }

  static Future<String?> getUnlockPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_unlockPasswordKey);
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
