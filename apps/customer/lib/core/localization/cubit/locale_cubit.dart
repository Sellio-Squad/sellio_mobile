import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  static const String _languageCodeKey = 'language_code';
  final SharedPreferences _prefs;

  LocaleCubit(this._prefs) : super(const LocaleState(locale: Locale('en'))) {
    _loadSavedLocale();
    PlatformDispatcher.instance.onLocaleChanged = () {
      _handleSystemLanguageChange();
    };
  }

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  Future<void> _loadSavedLocale() async {
    try {
      final savedCode = _prefs.getString(_languageCodeKey);
      print("Saved Code in Prefs: $savedCode");

      if (savedCode != null && savedCode.isNotEmpty) {
        emit(LocaleState(locale: Locale(savedCode)));
      } else {
        _detectDeviceLanguage();
      }
    } catch (e) {
      print("Error loading locale: $e");
      emit(const LocaleState(locale: Locale('en')));
    }
  }

  void _handleSystemLanguageChange() {
    final savedCode = _prefs.getString(_languageCodeKey);
    if (savedCode == null) {
      _detectDeviceLanguage();
    }
  }

  void _detectDeviceLanguage() {
    final deviceLangCode = PlatformDispatcher.instance.locale.languageCode;

    if (supportedLocales.any((l) => l.languageCode == deviceLangCode)) {
      emit(LocaleState(locale: Locale(deviceLangCode)));
    } else {
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
