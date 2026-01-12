import '../../../models/auth/forgot_password_otp_response.dart';
import '../../../models/auth/login_response.dart';
import '../../../models/auth/register_response.dart';
import '../../../models/auth/resend_otp_response.dart';
import '../../../models/auth/verify_otp_response.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login({
    required String phoneNumber,
    required String password,
  });

  Future<RegisterResponse> register({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String password,
    required String city,
    required String country,
    required String region,
  });

  Future<VerifyOtpResponse> verifyOtp({
    required String otp,
    required String sessionId,
  });

  Future<ResendOtpResponse> resendOtp({
    required String sessionId,
  });

  Future<ForgotPasswordOtpResponse> sendForgotPasswordOtp({
    required String phoneNumber,
    required String defaultRegion,
  });

  Future<void> verifyForgotPasswordOtp({
    required String otp,
    required String sessionId,
  });

  Future<void> resetPassword({
    required String sessionId,
    required String newPassword,
    required String confirmPassword,
  });

  Future<void> logout();
}