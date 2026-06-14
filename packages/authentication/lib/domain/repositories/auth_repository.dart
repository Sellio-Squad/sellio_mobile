import 'package:core/error/result.dart';

abstract class AuthRepository {
  Future<Result<void>> login({
    required String phoneNumber,
    required String password,
  });

  Future<Result<void>> register({
    required String fullName,
    required String phoneNumber,
    required String password,
    required String city,
    required String country,
    required String region,
    required String countryCode,
  });

  Future<Result<void>> verifyRegistrationOtp({
    required String otp,
  });

  Future<Result<String?>> resendOtp();

  Future<Result<void>> sendForgotPasswordOtp({
    required String phoneNumber,
    required String defaultRegion,
  });

  Future<Result<void>> verifyForgotPasswordOtp({
    required String otp,
  });

  Future<Result<void>> resetPassword({
    required String newPassword,
    required String confirmPassword,
  });

  Future<Result<void>> logout();

  Future<void> clearAuthData();

  Future<bool> isLoggedIn();

  Future<Result<void>> loginAsGuest();

  Future<bool> isGuestMode();

  Future<void> clearGuestMode();

  Future<String?> getPendingRegistrationPhone();

  Future<void> clearPendingRegistration();
}
