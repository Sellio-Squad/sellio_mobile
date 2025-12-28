
abstract class AuthConstants {
  AuthConstants._();

  static const int otpLength = 4;

  static const int otpResendCountdown = 55;

  static const int authTimeout = 30;

  static const int minPhoneLength = 10;
  static const int maxPhoneLength = 15;
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 20;
  static const int minNameLength = 2;
  static const int minLocationLength = 2;

  static final RegExp digitsOnly = RegExp(r'^[0-9]+$');
  static final RegExp lettersAndSpaces = RegExp(r'^[a-zA-Z\u0600-\u06FF ]+$');
  static final RegExp phoneWithCode = RegExp(r'^[+\d]+$');
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
}
