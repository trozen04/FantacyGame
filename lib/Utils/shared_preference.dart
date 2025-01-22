import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences? prefs;

  // Initialize SharedPreferences
  static Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    return prefs != null;
  }

  // Check if the 'isdashboard' key exists and return its value (true/false)
  static bool isDashboardLoaded() {
    return prefs?.getBool('isdashboard') ?? false;
  }

  // Optionally, you can set the 'isdashboard' value
  static Future<void> setDashboardLoaded(bool value) async {
    await prefs?.setBool('isdashboard', value);
  }
}
