import '../core/result.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  /// Login with phone number and password
  Future<Result<User>> login({
    required String phoneNumber,
    required String countryCode,
    required String password,
  });

  /// Register new user
  Future<Result<User>> register({
    required String fullName,
    required String phoneNumber,
    required String countryCode,
    required String password,
    required String country,
    required String city,
    String? profilePhotoUrl,
  });

  /// Verify OTP code
  Future<Result<bool>> verifyOtp({
    required String phoneNumber,
    required String countryCode,
    required String otpCode,
  });

  /// Resend OTP code
  Future<Result<void>> resendOtp({
    required String phoneNumber,
    required String countryCode,
  });

  /// Send forgot password OTP
  Future<Result<void>> sendForgotPasswordOtp({
    required String phoneNumber,
    required String countryCode,
  });

  /// Reset password
  Future<Result<void>> resetPassword({
    required String phoneNumber,
    required String countryCode,
    required String otpCode,
    required String newPassword,
  });

  /// Logout
  Future<Result<void>> logout();

  /// Get current user
  Future<Result<User?>> getCurrentUser();

  /// Check if user is logged in
  Future<Result<bool>> isLoggedIn();

  /// Get stored auth token
  Future<Result<String?>> getAuthToken();
}