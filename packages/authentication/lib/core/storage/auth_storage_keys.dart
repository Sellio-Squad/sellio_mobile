import 'package:core/core.dart';

abstract class AuthStorageKeys {
  AuthStorageKeys._();

  // Tokens (Mapped to Core for Network Interceptor consistency)
  static const String authToken = CoreStorageKeys.authToken;
  static const String refreshToken = CoreStorageKeys.refreshToken;
  static const String isLoggedIn = CoreStorageKeys.isLoggedIn;

  // Internal Auth Flow Keys (Private to this package)
  static const String isGuestMode = 'is_guest_mode';
  static const String registrationSessionId = 'registration_session_id';
  static const String registrationPhoneNumber = 'registration_phone_number';
  static const String forgotPasswordSessionId = 'forgot_password_session_id';
}
