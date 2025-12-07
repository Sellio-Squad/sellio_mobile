import '../../../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String phoneNumber,
    required String countryCode,
    required String password,
  });

  Future<UserModel> register({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String countryCode,
    required String password,
    required String country,
    required String city,
  });

  Future<bool> verifyOtp({
    required String phoneNumber,
    required String countryCode,
    required String otpCode,
  });

  Future<void> resendOtp({
    required String phoneNumber,
    required String countryCode,
  });

  Future<void> sendForgotPasswordOtp({
    required String phoneNumber,
    required String countryCode,
  });

  Future<void> resetPassword({
    required String phoneNumber,
    required String countryCode,
    required String otpCode,
    required String newPassword,
  });

  Future<UserModel?> getCurrentUser(String userId);
}
