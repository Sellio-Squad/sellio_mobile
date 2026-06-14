import 'package:flutter/material.dart';
import '../../../core/localization/auth_localization_service.dart';

enum AuthErrorType {
  // Login errors
  loginFailed,

  // Account creation errors
  accountCreationFailed,

  // OTP errors
  otpVerificationFailed,
  otpExpired,
  otpInvalid,

  // Password reset errors
  passwordResetFailed,
  invalidResetToken,

  // General errors
  networkError,
  unknownError;

  String toLocalizedString(BuildContext context) {
    return switch (this) {
      AuthErrorType.loginFailed => context.authLocal.login_failed,
      AuthErrorType.accountCreationFailed =>
        context.authLocal.failed_to_create_account,
      AuthErrorType.otpVerificationFailed =>
        context.authLocal.otp_verification_failed,
      AuthErrorType.otpExpired => context.authLocal.otp_verification_failed,
      AuthErrorType.otpInvalid => context.authLocal.otp_verification_failed,
      AuthErrorType.passwordResetFailed => context.authLocal.login_failed,
      AuthErrorType.invalidResetToken => context.authLocal.login_failed,
      AuthErrorType.networkError => context.authLocal.login_failed,
      AuthErrorType.unknownError => context.authLocal.login_failed,
    };
  }
}
