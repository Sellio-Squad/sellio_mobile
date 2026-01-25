import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'enums/auth_error_type.dart';
import 'enums/validation_error_type.dart';

extension ValidationErrorLocalization on ValidationErrorType {
  String toLocalizedString(BuildContext context) {
    return switch (this) {
    // Phone errors
      ValidationErrorType.phoneMinLength =>
      context.local.phone_number_must_be_at_least_10_digits,
      ValidationErrorType.phoneDigitsOnly =>
      context.local.phone_number_digits_only,

    // Password errors
      ValidationErrorType.passwordMinLength =>
      context.local.password_min_6_characters,
      ValidationErrorType.passwordMaxLength =>
      context.local.password_max_20_characters,
      ValidationErrorType.passwordsDoNotMatch =>
      context.local.passwords_do_not_match,

    // First Name errors
      ValidationErrorType.fullNameMinLength =>
      context.local.full_name_at_least_2_characters,
      ValidationErrorType.fullNameLettersOnly =>
      context.local.full_name_letters_only,

    // Email errors
      ValidationErrorType.emailEmpty =>
      context.local.email_required,
      ValidationErrorType.emailInvalid =>
      context.local.email_invalid,

    // City errors
      ValidationErrorType.cityMinLength =>
      context.local.city_at_least_2_characters,
      ValidationErrorType.cityLettersOnly =>
      context.local.city_letters_only,
    };
  }
}

extension AuthErrorLocalization on AuthErrorType {
  String toLocalizedString(BuildContext context) {
    return switch (this) {
      // Login errors
      AuthErrorType.loginFailed => context.local.something_went_wrong,

      // Account creation errors
      AuthErrorType.accountCreationFailed =>
        context.local.failed_to_create_account,

      // OTP errors
      AuthErrorType.otpVerificationFailed =>
        context.local.something_went_wrong,
      AuthErrorType.otpExpired => context.local.something_went_wrong,
      AuthErrorType.otpInvalid => context.local.something_went_wrong,

      // Password reset errors
      AuthErrorType.passwordResetFailed => context.local.something_went_wrong,
      AuthErrorType.invalidResetToken => context.local.something_went_wrong,

      // General errors
      AuthErrorType.networkError => context.local.something_went_wrong,
      AuthErrorType.unknownError => context.local.something_went_wrong,
    };
  }
}
