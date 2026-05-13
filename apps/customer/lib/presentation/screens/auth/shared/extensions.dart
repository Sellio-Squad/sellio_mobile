import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'enums/auth_error_type.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_intl_phone_field/countries.dart' as intl_countries;

extension CountryExtensions on Country {
  int? get maxPhoneLength {
    if (countryCode.isEmpty) return null;

    try {
      final countryData = intl_countries.countries.firstWhere(
        (c) => c.code.toUpperCase() == countryCode.toUpperCase(),
      );

      return countryData.maxLength;
    } catch (e) {
      return 10;
    }
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
      AuthErrorType.otpVerificationFailed => context.local.something_went_wrong,
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
