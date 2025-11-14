import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_localizations.dart';

class LocalizationService {
  static const _languageCodeKey = 'language_code';

  final ValueNotifier<Locale> _locale = ValueNotifier(const Locale('en'));

  Locale get currentLocale => _locale.value;
  ValueNotifier<Locale> get localeNotifier => _locale;

  LocalizationService() {
    _loadSavedLocale();
  }

  void _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_languageCodeKey) ?? 'en';
    _locale.value = Locale(code);
  }

  void changeLocale(Locale locale) async {
    _locale.value = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageCodeKey, locale.languageCode);
  }

  List<Locale> get supportedLocales => const [
    Locale('en'),
    Locale('ar'),
  ];
}

extension L10nX on BuildContext {
  AppLocalizations get local => AppLocalizations.of(this);
}