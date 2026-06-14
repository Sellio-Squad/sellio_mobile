import 'package:core/core.dart';
import '../../models/auth/forgot_password_otp_response.dart';
import '../../models/auth/forgot_password_request.dart';
import '../../models/auth/forgot_password_reset_request.dart';
import '../../models/auth/login_request.dart';
import '../../models/auth/login_response.dart';
import '../../models/auth/register_request.dart';
import '../../models/auth/register_response.dart';
import '../../models/auth/resend_otp_response.dart';
import '../../models/auth/verify_otp_request.dart';
import '../../models/auth/verify_otp_response.dart';
import 'auth_endpoints.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;
  final AuthEndpoints _endpoints;

  AuthRemoteDataSourceImpl(this._apiClient, this._endpoints);

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
      _endpoints.login,
      data: request.toJson(),
    );

    return LoginResponse.fromJson(response.data);
  }

  @override
  Future<RegisterResponse> register({
    required String fullName,
    required String phoneNumber,
    required String password,
    required String city,
    required String country,
    required String region,
    required String countryCode,
  }) async {
    final request = RegisterRequest(
      fullName: fullName,
      phoneNumber: phoneNumber,
      password: password,
      city: city,
      country: country,
      region: region,
      countryCode: countryCode,
    );

    final response = await _apiClient.post(
      _endpoints.register,
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
      _endpoints.verifyOtp,
      data: request.toJson(),
    );

    return VerifyOtpResponse.fromJson(response.data);
  }

  @override
  Future<ResendOtpResponse> resendOtp({
    required String sessionId,
  }) async {
    final response = await _apiClient.post(
      '${_endpoints.resendOtp}/$sessionId',
    );

    return ResendOtpResponse.fromJson(response.data);
  }

  @override
  Future<ForgotPasswordOtpResponse> sendForgotPasswordOtp({
    required String phoneNumber,
    required String defaultRegion,
  }) async {
    final request = ForgotPasswordRequest(
      phoneNumber: phoneNumber,
      defaultRegion: defaultRegion,
    );

    final response = await _apiClient.post(
      _endpoints.forgotPassword,
      data: request.toJson(),
    );

    return ForgotPasswordOtpResponse.fromJson(response.data);
  }

  @override
  Future<void> verifyForgotPasswordOtp({
    required String otp,
    required String sessionId,
  }) async {
    final data = {
      'otp': otp,
      'sessionId': sessionId,
    };

    await _apiClient.post(
      _endpoints.verifyForgotPasswordOtp,
      data: data,
    );
  }

  @override
  Future<void> resetPassword({
    required String sessionId,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final request = ForgotPasswordResetRequest(
      sessionId: sessionId,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );

    await _apiClient.post(
      _endpoints.resetForgotPassword,
      data: request.toJson(),
    );
  }
}
