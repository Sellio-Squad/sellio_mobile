import '../../core/api/api_endpoints.dart';
import '../../core/api/http_client.dart';
import '../../models/user_model.dart';

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

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final HttpClient _httpClient;

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
    final response = await _httpClient.get(ApiEndpoints.userById(userId));
    return UserModel.fromJson(response.data);
  }
}