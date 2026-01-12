import '../../core/error/result.dart';

abstract class AuthRepository {
  Future<Result<void>> login({
    required String phoneNumber,
    required String password,
  });

  Future<Result<void>> register({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String password,
    required String city,
    required String country,
    required String email,
    required String region,
  });

  Future<Result<void>> verifyRegistrationOtp({
    required String otp,
  });

  Future<Result<void>> resendRegistrationOtp();

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

  Future<String?> getPendingRegistrationPhone();

  Future<void> clearPendingRegistration();
}