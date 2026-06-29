import 'package:flutter/material.dart';
import '../../core/localization/auth_localization_service.dart';

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
        context.authLocal.phone_number_must_be_at_least_10_digits,
      PhoneValidationError.digitsOnly =>
        context.authLocal.phone_number_digits_only,
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
        context.authLocal.password_min_6_characters,
      PasswordValidationError.maxLength =>
        context.authLocal.password_max_20_characters,
      PasswordValidationError.passwordsDoNotMatch =>
        context.authLocal.passwords_do_not_match,
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
        context.authLocal.full_name_at_least_2_characters,
      FullNameValidationError.lettersOnly =>
        context.authLocal.full_name_letters_only,
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
      CityValidationError.minLength => context.authLocal.city_at_least_2_characters,
      CityValidationError.lettersOnly => context.authLocal.city_letters_only,
    };
  }
}
