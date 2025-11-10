import 'package:dio/dio.dart';

import '../../models/user_model.dart';
import 'api_service/api_service.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String phoneNumber,
    required String countryCode,
    required String password,
  });

  Future<UserModel> register({
    required String fullName,
    required String phoneNumber,
    required String countryCode,
    required String password,
    required String country,
    required String city,
    String? profilePhotoUrl,
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

  Future<void> logout();

  Future<UserModel> getCurrentUser();

  Future<Map<String, String>> refreshToken(String refreshToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService _apiService;

  AuthRemoteDataSourceImpl(this._apiService);

  @override
  Future<UserModel> login({
    required String phoneNumber,
    required String countryCode,
    required String password,
  }) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/auth/login',
        data: {
          'phoneNumber': phoneNumber,
          'countryCode': countryCode,
          'password': password,
        },
      );

      return UserModel.fromJson(
          response.data!['data']['user'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<UserModel> register({
    required String fullName,
    required String phoneNumber,
    required String countryCode,
    required String password,
    required String country,
    required String city,
    String? profilePhotoUrl,
  }) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/auth/register',
        data: {
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'countryCode': countryCode,
          'password': password,
          'country': country,
          'city': city,
          if (profilePhotoUrl != null) 'profilePhotoUrl': profilePhotoUrl,
        },
      );

      return UserModel.fromJson(
          response.data!['data']['user'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<bool> verifyOtp({
    required String phoneNumber,
    required String countryCode,
    required String otpCode,
  }) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/auth/verify-otp',
        data: {
          'phoneNumber': phoneNumber,
          'countryCode': countryCode,
          'otpCode': otpCode,
        },
      );

      return response.data!['data']['verified'] as bool;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> resendOtp({
    required String phoneNumber,
    required String countryCode,
  }) async {
    try {
      await _apiService.post(
        '/auth/resend-otp',
        data: {
          'phoneNumber': phoneNumber,
          'countryCode': countryCode,
        },
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> sendForgotPasswordOtp({
    required String phoneNumber,
    required String countryCode,
  }) async {
    try {
      await _apiService.post(
        '/auth/forgot-password',
        data: {
          'phoneNumber': phoneNumber,
          'countryCode': countryCode,
        },
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> resetPassword({
    required String phoneNumber,
    required String countryCode,
    required String otpCode,
    required String newPassword,
  }) async {
    try {
      await _apiService.post(
        '/auth/reset-password',
        data: {
          'phoneNumber': phoneNumber,
          'countryCode': countryCode,
          'otpCode': otpCode,
          'newPassword': newPassword,
        },
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _apiService.post('/auth/logout');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/auth/me',
      );

      return UserModel.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<Map<String, String>> refreshToken(String refreshToken) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: {
          'refreshToken': refreshToken,
        },
      );

      final data = response.data!['data'] as Map<String, dynamic>;
      return {
        'token': data['token'] as String,
        'refreshToken': data['refreshToken'] as String,
      };
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final message =
          e.response!.data['message'] as String? ?? 'Unknown error occurred';

      switch (statusCode) {
        case 400:
          return Exception('Bad request: $message');
        case 401:
          return Exception('Unauthorized: $message');
        case 404:
          return Exception('Not found: $message');
        case 500:
          return Exception('Server error: $message');
        default:
          return Exception('Error: $message');
      }
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return Exception('Connection timeout');
    } else if (e.type == DioExceptionType.connectionError) {
      return Exception('No internet connection');
    } else {
      return Exception('Unknown error occurred');
    }
  }
}
