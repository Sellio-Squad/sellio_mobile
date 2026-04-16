import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

// Base sealed class
sealed class ValidationError {
  String toLocalizedString(BuildContext context);
}

// Phone validation errors
enum PhoneValidationError implements ValidationError {
  minLength,
  digitsOnly;

  @override
  String toLocalizedString(BuildContext context) {
    return switch (this) {
      PhoneValidationError.minLength =>
        context.local.phone_number_must_be_at_least_10_digits,
      PhoneValidationError.digitsOnly => context.local.phone_number_digits_only,
    };
  }
}

// Password validation errors
enum PasswordValidationError implements ValidationError {
  minLength,
  maxLength,
  passwordsDoNotMatch;

  @override
  String toLocalizedString(BuildContext context) {
    return switch (this) {
      PasswordValidationError.minLength =>
        context.local.password_min_6_characters,
      PasswordValidationError.maxLength =>
        context.local.password_max_20_characters,
      PasswordValidationError.passwordsDoNotMatch =>
        context.local.passwords_do_not_match,
    };
  }
}

// Full Name validation errors
enum FullNameValidationError implements ValidationError {
  minLength,
  lettersOnly;

  @override
  String toLocalizedString(BuildContext context) {
    return switch (this) {
      FullNameValidationError.minLength =>
        context.local.full_name_at_least_2_characters,
      FullNameValidationError.lettersOnly =>
        context.local.full_name_letters_only,
    };
  }
}

// City validation errors
enum CityValidationError implements ValidationError {
  minLength,
  lettersOnly;

  @override
  String toLocalizedString(BuildContext context) {
    return switch (this) {
      CityValidationError.minLength => context.local.city_at_least_2_characters,
      CityValidationError.lettersOnly => context.local.city_letters_only,
    };
  }
}
