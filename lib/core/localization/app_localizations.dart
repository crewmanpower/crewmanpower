import 'package:flutter/material.dart';
import 'en.dart';
import 'hi.dart';
import 'ur.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': en,
    'hi': hi,
    'ur': ur,
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  String translateFormatted(String key, Map<String, String> args) {
    String value = translate(key);
    args.forEach((argKey, argValue) {
      value = value.replaceAll('{$argKey}', argValue);
    });
    return value;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'hi', 'ur'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

const appLocalizationsDelegate = AppLocalizationsDelegate();
