import '../../../core/api/api_client.dart';
import '../../../core/api/api_endpoints.dart';
import '../../../models/user_model.dart';
import 'auth_remote.dart';


class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _httpClient;

  AuthRemoteDataSourceImpl(this._httpClient);

  @override
  Future<UserModel> login({
    required String phoneNumber,
    required String countryCode,
    required String password,
  }) async {
    final response = await _httpClient.post(
      ApiEndpoints.login,
      data: {
        'phoneNumber': phoneNumber,
        'countryCode': countryCode,
        'password': password,
      },
    );

    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> register({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String countryCode,
    required String password,
    required String country,
    required String city,
  }) async {
    final response = await _httpClient.post(
      ApiEndpoints.userInsert,
      data: {
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'password': password,
        'city': city,
        'country': country,
      },
    );

    return UserModel.fromJson(response.data);
  }

  @override
  Future<bool> verifyOtp({
    required String phoneNumber,
    required String countryCode,
    required String otpCode,
  }) async {
    final response = await _httpClient.post(
      ApiEndpoints.verifyOtp,
      data: {
        'phoneNumber': phoneNumber,
        'countryCode': countryCode,
        'otpCode': otpCode,
      },
    );

    return response.data['verified'] as bool? ?? false;
  }

  @override
  Future<void> resendOtp({
    required String phoneNumber,
    required String countryCode,
  }) async {
    await _httpClient.post(
      ApiEndpoints.resendOtp,
      data: {
        'phoneNumber': phoneNumber,
        'countryCode': countryCode,
      },
    );
  }

  @override
  Future<void> sendForgotPasswordOtp({
    required String phoneNumber,
    required String countryCode,
  }) async {
    await _httpClient.post(
      ApiEndpoints.forgotPassword,
      data: {
        'phoneNumber': phoneNumber,
        'countryCode': countryCode,
      },
    );
  }

  @override
  Future<void> resetPassword({
    required String phoneNumber,
    required String countryCode,
    required String otpCode,
    required String newPassword,
  }) async {
    await _httpClient.post(
      ApiEndpoints.resetPassword,
      data: {
        'phoneNumber': phoneNumber,
        'countryCode': countryCode,
        'otpCode': otpCode,
        'newPassword': newPassword,
      },
    );
  }

  @override
  Future<UserModel?> getCurrentUser(String userId) async {
    final response = await _httpClient.get(ApiEndpoints.userProfile());
    return UserModel.fromJson(response.data);
  }

  @override
  Future<void> logout() async {
    await _httpClient.post(ApiEndpoints.logout);
  }
}
