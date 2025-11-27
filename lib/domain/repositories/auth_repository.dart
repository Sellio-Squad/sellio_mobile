import '../../core/error/result.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Result<User>> login({
    required String phoneNumber,
    required String countryCode,
    required String password,
  });

  Future<Result<String>> createAccount({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String countryCode,
    required String password,
    required String country,
    required String city,
    String? profilePhotoUrl,
  });

  Future<Result<bool>> verifyOtp({
    required String sessionId,
    required String otpCode,
  });

  Future<Result<void>> resendOtp({
    required String phoneNumber,
    required String countryCode,
  });

  Future<Result<void>> sendForgotPasswordOtp({
    required String phoneNumber,
    required String countryCode,
  });

  Future<Result<void>> resetPassword({
    required String phoneNumber,
    required String countryCode,
    required String otpCode,
    required String newPassword,
  });

  Future<Result<void>> logout();

  Future<Result<User?>> getCurrentUser();

  Future<Result<bool>> isLoggedIn();

  Future<Result<String?>> getAuthToken();
}