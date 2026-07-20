import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalePreferences {
  static const _localeKey = 'selected_locale';

  static Future<void> saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, locale.languageCode);
  }

  static Future<Locale> getSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(_localeKey);
    if (languageCode != null && ['en', 'hi', 'ur'].contains(languageCode)) {
      return Locale(languageCode);
    }
    return const Locale('en');
  }
}
