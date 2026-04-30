import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  static const String _keyIsLoggedIn = "is_logged_in";
  static const String _keyUserEmail = "user_email";
  static const String _keyUserUID = "user_uid";
  static const String _keyIsFirstTime = "is_first_time";

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Auth Status
  static Future<void> setLoggedIn(bool value) async {
    await _prefs?.setBool(_keyIsLoggedIn, value);
  }

  static bool isLoggedIn() {
    return _prefs?.getBool(_keyIsLoggedIn) ?? false;
  }

  // User Data
  static Future<void> setUserEmail(String email) async {
    await _prefs?.setString(_keyUserEmail, email);
  }

  static String getUserEmail() {
    return _prefs?.getString(_keyUserEmail) ?? "";
  }

  static Future<void> setUserUID(String uid) async {
    await _prefs?.setString(_keyUserUID, uid);
  }

  static String getUserUID() {
    return _prefs?.getString(_keyUserUID) ?? "";
  }

  // Onboarding
  static Future<void> setFirstTime(bool value) async {
    await _prefs?.setBool(_keyIsFirstTime, value);
  }


  static bool isFirstTime() {
    return _prefs?.getBool(_keyIsFirstTime) ?? true;
  }

  // Clear all data (Logout)
  static Future<void> clear() async {
    await _prefs?.clear();
  }
}
