import '../../../core/api/api_endpoints.dart';
import '../../../core/api/api_client.dart';
import '../../../models/auth/auth_tokens_response_model.dart';
import '../../../models/auth/register_response_model.dart';
import '../../../models/user_model.dart';
import 'auth_remote.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _httpClient;

  AuthRemoteDataSourceImpl(this._httpClient);

  String _formatPhoneNumber(String countryCode, String phoneNumber) {
    final formattedCountryCode =
        countryCode.startsWith('+') ? countryCode : '+' + countryCode;
    return '$formattedCountryCode$phoneNumber';
  }

  @override
  Future<AuthTokensResponseModel> login({
    required String phoneNumber,
    required String countryCode,
    required String password,
  }) async {
    final fullPhoneNumber = _formatPhoneNumber(countryCode, phoneNumber);

    final response = await _httpClient.post(
      ApiEndpoints.login,
      data: {
        'phoneNumber': fullPhoneNumber,
        'password': password,
      },
    );

    return AuthTokensResponseModel.fromJson(response.data);
  }

  @override
  Future<RegisterResponseModel> register({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String countryCode,
    required String password,
    required String country,
    required String city,
    required String region,
  }) async {
    final fullPhoneNumber = _formatPhoneNumber(countryCode, phoneNumber);

    final response = await _httpClient.post(
      ApiEndpoints.createUser,
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': fullPhoneNumber,
        'password': password,
        'city': city,
        'country': country,
        'region': region,
      },
    );

    return RegisterResponseModel.fromJson(response.data);
  }

  @override
  Future<AuthTokensResponseModel> verifyOtp({
    required String sessionId,
    required String otp,
  }) async {
    final response = await _httpClient.post(
      ApiEndpoints.verifyOtp,
      data: {
        'sessionId': sessionId,
        'otp': otp,
      },
    );

    return AuthTokensResponseModel.fromJson(response.data);
  }

  @override
  Future<void> resendOtp({
    required String sessionId,
  }) async {
    await _httpClient.post(
      ApiEndpoints.resendOtp,
      data: {
        'sessionId': sessionId,
      },
    );
  }

  @override
  Future<String> sendForgotPasswordOtp({
    required String phoneNumber,
    required String defaultRegion,
  }) async {
    final response = await _httpClient.post(
      ApiEndpoints.forgotPasswordRequest,
      data: {
        'phoneNumber': phoneNumber,
        'defaultRegion': defaultRegion,
      },
    );
    // Assuming the backend returns a JSON with a 'sessionId' key
    return response.data['sessionId'];
  }

  @override
  Future<void> verifyForgotPasswordOtp({
    required String sessionId,
    required String otp,
  }) async {
    await _httpClient.post(
      ApiEndpoints.forgotPasswordVerify,
      data: {
        'sessionId': sessionId,
        'otp': otp,
      },
    );
  }

  @override
  Future<void> resetPassword({
    required String sessionId,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await _httpClient.post(
      ApiEndpoints.forgotPasswordReset,
      data: {
        'sessionId': sessionId,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      },
    );
  }

  @override
  Future<UserModel?> getCurrentUser(String userId) async {
    final response = await _httpClient.get(ApiEndpoints.userProfile());
    return UserModel.fromJson(response.data);
  }
}
