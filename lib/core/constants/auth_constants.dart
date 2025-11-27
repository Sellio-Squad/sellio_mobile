class AuthConstants {
  AuthConstants._();

  // Duration constants
  static const Duration snackBarDisplayDuration = Duration(seconds: 4);
  static const Duration successSnackBarDisplayDuration = Duration(seconds: 3);
  static const Duration navigationDelay = Duration(milliseconds: 1500);
  static const Duration errorClearDelay = Duration(milliseconds: 100);

  // Form validation constants
  static const int minPhoneLength = 10;
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 20;
  static const int minNameLength = 2;
  static const int minLocationLength = 2;
  static const int maxPhoneInputLength = 11;

  // Default country code
  static const String defaultCountryCode = '+964';
}

