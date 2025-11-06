import '../entities/user.dart';

abstract class AuthRepository {
  /// Login with phone number and password
  Future<User> login({
    required String phoneNumber,
    required String countryCode,
    required String password,
  });

  /// Register new user
  Future<User> register({
    required String fullName,
    required String phoneNumber,
    required String countryCode,
    required String password,
    required String country,
    required String city,
    String? profilePhotoUrl,
  });

  /// Verify OTP code
  Future<bool> verifyOtp({
    required String phoneNumber,
    required String countryCode,
    required String otpCode,
  });

  /// Resend OTP code
  Future<void> resendOtp({
    required String phoneNumber,
    required String countryCode,
  });

  /// Send forgot password OTP
  Future<void> sendForgotPasswordOtp({
    required String phoneNumber,
    required String countryCode,
  });

  /// Reset password
  Future<void> resetPassword({
    required String phoneNumber,
    required String countryCode,
    required String otpCode,
    required String newPassword,
  });

  /// Logout
  Future<void> logout();

  /// Get current user
  Future<User?> getCurrentUser();

  /// Check if user is logged in
  Future<bool> isLoggedIn();

  /// Get stored auth token
  Future<String?> getAuthToken();
}