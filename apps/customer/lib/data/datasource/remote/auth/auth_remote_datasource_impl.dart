import '../../../core/api/api_client.dart';
import '../../../core/api/api_endpoints.dart';
import '../../../models/auth/login_request.dart';
import '../../../models/auth/login_response.dart';
import '../../../models/auth/register_request.dart';
import '../../../models/auth/register_response.dart';
import '../../../models/auth/resend_otp_request.dart';
import '../../../models/auth/resend_otp_response.dart';
import '../../../models/auth/verify_otp_request.dart';
import '../../../models/auth/verify_otp_response.dart';
import '../../../models/auth/forgot_password_request.dart';
import '../../../models/auth/reset_password_request.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<LoginResponse> login({
    required String phoneNumber,
    required String password,
  }) async {
    final request = LoginRequest(
      phoneNumber: phoneNumber,
      password: password,
    );

    final response = await _apiClient.post(
      ApiEndpoints.login,
      data: request.toJson(),
    );

    return LoginResponse.fromJson(response.data);
  }

  @override
  Future<RegisterResponse> register({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String password,
    required String city,
    required String country,
    required String email,
    required String region,
  }) async {
    final request = RegisterRequest(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      password: password,
      city: city,
      country: country,
      email: email,
      region: region,
    );

    final response = await _apiClient.post(
      ApiEndpoints.register,
      data: request.toJson(),
    );

    return RegisterResponse.fromJson(response.data);
  }

  @override
  Future<VerifyOtpResponse> verifyOtp({
    required String otp,
    required String sessionId,
  }) async {
    final request = VerifyOtpRequest(
      otp: otp,
      sessionId: sessionId,
    );

    final response = await _apiClient.post(
      ApiEndpoints.verifyOtp,
      data: request.toJson(),
    );

    return VerifyOtpResponse.fromJson(response.data);
  }

  @override
  Future<ResendOtpResponse> resendOtp({
    required String sessionId,
  }) async {
    final request = ResendOtpRequest(sessionId: sessionId);

    final response = await _apiClient.post(
      ApiEndpoints.resendOtp,
      data: request.toJson(),
    );

    return ResendOtpResponse.fromJson(response.data);
  }

  @override
  Future<void> sendForgotPasswordOtp({
    required String phoneNumber,
  }) async {
    final request = ForgotPasswordRequest(phoneNumber: phoneNumber);

    await _apiClient.post(
      ApiEndpoints.forgotPassword,
      data: request.toJson(),
    );
  }

  @override
  Future<void> resetPassword({
    required String phoneNumber,
    required String otp,
    required String newPassword,
  }) async {
    final request = ResetPasswordRequest(
      phoneNumber: phoneNumber,
      otp: otp,
      newPassword: newPassword,
    );

    await _apiClient.post(
      ApiEndpoints.resetPassword,
      data: request.toJson(),
    );
  }

  @override
  Future<void> logout() async {
    await _apiClient.post(ApiEndpoints.logout);
  }
}