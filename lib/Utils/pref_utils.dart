import 'dart:convert';

import 'package:fantacy_game/Utils/shared_preference.dart';



class PrefUtils {
  static void setToken(String value) {
    Prefs.prefs?.setString(SharedPrefsKeys.token, value);
  }

  static String getToken() {
    final String? value = Prefs.prefs?.getString(SharedPrefsKeys.token);
    return value ?? '';
  }

  static void setRememberme(bool value) {
    Prefs.prefs?.setBool(SharedPrefsKeys.rememberme, value);
  }

  static bool getRememberme() {
    final bool? value = Prefs.prefs?.getBool(SharedPrefsKeys.rememberme);
    return value ?? false;
  }


}


class SharedPrefsKeys {
  static const token = 'token';
  static const rememberme = 'rememberme';
}
