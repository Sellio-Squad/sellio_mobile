import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  static const String _languageCodeKey = 'language_code';
  final SharedPreferences _prefs;

  LocaleCubit(this._prefs) : super(const LocaleState(locale: Locale('en'))) {
    _loadSavedLocale();
  }

  // Supported locales
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  Future<void> _loadSavedLocale() async {
    try {
      final code = _prefs.getString(_languageCodeKey) ?? 'en';
      final locale = Locale(code);

      if (supportedLocales.contains(locale)) {
        emit(LocaleState(locale: locale));
      }
    } catch (e) {
      // Fallback to English on error
      emit(const LocaleState(locale: Locale('en')));
    }
  }

  Future<void> changeLocale(Locale newLocale) async {
    if (!supportedLocales.contains(newLocale)) {
      throw UnsupportedError('Locale $newLocale is not supported');
    }

    try {
      await _prefs.setString(_languageCodeKey, newLocale.languageCode);
      emit(LocaleState(locale: newLocale));
    } catch (e) {
      // Handle error, maybe show snackbar
      rethrow;
    }
  }

  String getLocaleName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'ar':
        return 'العربية';
      default:
        return locale.languageCode.toUpperCase();
    }
  }

  bool isRTL(Locale locale) => locale.languageCode == 'ar';
}