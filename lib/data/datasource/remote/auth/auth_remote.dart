import '../../../models/auth/auth_tokens_response_model.dart';
import '../../../models/auth/register_response_model.dart';
import '../../../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthTokensResponseModel> login({
    required String phoneNumber,
    required String countryCode,
    required String password,
  });

  Future<RegisterResponseModel> register({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String countryCode,
    required String password,
    required String country,
    required String city,
    required String region,
  });

  Future<AuthTokensResponseModel> verifyOtp({
    required String sessionId,
    required String otp,
  });

  Future<void> resendOtp({
    required String sessionId,
  });

  Future<String> sendForgotPasswordOtp({
    required String phoneNumber,
    required String defaultRegion,
  });

  Future<void> verifyForgotPasswordOtp({
    required String sessionId,
    required String otp,
  });

  Future<void> resetPassword({
    required String sessionId,
    required String newPassword,
    required String confirmPassword,
  });

  Future<UserModel?> getCurrentUser(String userId);
}
