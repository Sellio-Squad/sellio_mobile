import '../../core/error/result.dart';
import '../entities/auth_tokens.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Result<AuthTokens>> login({
    required String phoneNumber,
    required String countryCode,
    required String password,
  });

  Future<Result<String>> register({
    required String fullName,
    required String phoneNumber,
    required String countryCode,
    required String password,
    required String country,
    required String city,
    required String region,
    String? profilePhotoUrl,
  });

  Future<Result<AuthTokens>> verifyOtp({
    required String sessionId,
    required String otp,
  });

  Future<Result<void>> resendOtp({
    required String sessionId,
  });

  Future<Result<String>> sendForgotPasswordOtp({
    required String phoneNumber,
    required String defaultRegion,
  });

  Future<Result<void>> verifyForgotPasswordOtp({
    required String sessionId,
    required String otp,
  });

  Future<Result<void>> resetPassword({
    required String sessionId,
    required String newPassword,
    required String confirmPassword,
  });

  Future<Result<void>> logout();

  Future<Result<User?>> getCurrentUser();

  Future<Result<bool>> isLoggedIn();

  Future<Result<String?>> getAuthToken();
}
