import 'package:sellio_mobile/core/localization/l10n/app_localizations.dart';

class AuthValidators {
  static String? validatePhone(String? value, AppLocalizations localizations) {
    if (value == null || value.isEmpty) return null;
    if (value.length < 10) {
      return localizations.phone_number_must_be_at_least_10_digits;
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return localizations.phone_number_digits_only;
    }
    return null;
  }

  static String? validateFullName(String? value, AppLocalizations localizations) {
    if (value == null || value.isEmpty) return null;
    if (value.length < 2) {
      return localizations.full_name_at_least_2_characters;
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return localizations.full_name_letters_only;
    }
    return null;
  }

  static String? validateCountry(String? value, AppLocalizations localizations) {
    if (value == null || value.isEmpty) return null;
    if (value.length < 2) {
      return localizations.country_at_least_2_characters;
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return localizations.country_letters_only;
    }
    return null;
  }

  static String? validateCity(String? value, AppLocalizations localizations) {
    if (value == null || value.isEmpty) return null;
    if (value.length < 2) {
      return localizations.city_at_least_2_characters;
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return localizations.city_letters_only;
    }
    return null;
  }

  static String? validatePassword(String? value, AppLocalizations localizations) {
    if (value == null || value.isEmpty) return null;
    if (value.length < 6) {
      return localizations.password_min_6_characters;
    }
    if (value.length > 20) {
      return localizations.password_max_20_characters;
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
    AppLocalizations localizations,
  ) {
    if (password != confirmPassword) {
      return localizations.passwords_do_not_match;
    }
    return null;
  }
}

