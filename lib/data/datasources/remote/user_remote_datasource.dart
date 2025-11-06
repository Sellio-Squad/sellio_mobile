import 'package:dio/dio.dart';

import '../../models/address_model.dart';
import '../../models/user_model.dart';
import 'api_service/api_service.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUserProfile();

  Future<UserModel> updateUserProfile({
    String? fullName,
    String? email,
    String? profilePhotoUrl,
  });

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<List<AddressModel>> getUserAddresses();

  Future<AddressModel> addAddress({
    required String country,
    required String city,
    required String street,
    String? buildingNumber,
    String? floor,
    String? apartment,
    double? latitude,
    double? longitude,
    bool isDefault = false,
  });

  Future<AddressModel> updateAddress({
    required String addressId,
    String? country,
    String? city,
    String? street,
    String? buildingNumber,
    String? floor,
    String? apartment,
    double? latitude,
    double? longitude,
    bool? isDefault,
  });

  Future<void> deleteAddress(String addressId);

  Future<void> setDefaultAddress(String addressId);

  Future<String> uploadProfilePhoto(String filePath);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiService _apiService;

  UserRemoteDataSourceImpl(this._apiService);

  @override
  Future<UserModel> getUserProfile() async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/users/me',
      );

      return UserModel.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<UserModel> updateUserProfile({
    String? fullName,
    String? email,
    String? profilePhotoUrl,
  }) async {
    try {
      final response = await _apiService.patch<Map<String, dynamic>>(
        '/users/me',
        data: {
          if (fullName != null) 'fullName': fullName,
          if (email != null) 'email': email,
          if (profilePhotoUrl != null) 'profilePhotoUrl': profilePhotoUrl,
        },
      );

      return UserModel.fromJson(response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _apiService.post(
        '/users/change-password',
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<AddressModel>> getUserAddresses() async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/users/addresses',
      );

      final data = response.data!['data'] as List<dynamic>;
      return data
          .map((json) => AddressModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<AddressModel> addAddress({
    required String country,
    required String city,
    required String street,
    String? buildingNumber,
    String? floor,
    String? apartment,
    double? latitude,
    double? longitude,
    bool isDefault = false,
  }) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/users/addresses',
        data: {
          'country': country,
          'city': city,
          'street': street,
          if (buildingNumber != null) 'buildingNumber': buildingNumber,
          if (floor != null) 'floor': floor,
          if (apartment != null) 'apartment': apartment,
          if (latitude != null) 'latitude': latitude,
          if (longitude != null) 'longitude': longitude,
          'isDefault': isDefault,
        },
      );

      return AddressModel.fromJson(
          response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<AddressModel> updateAddress({
    required String addressId,
    String? country,
    String? city,
    String? street,
    String? buildingNumber,
    String? floor,
    String? apartment,
    double? latitude,
    double? longitude,
    bool? isDefault,
  }) async {
    try {
      final response = await _apiService.patch<Map<String, dynamic>>(
        '/users/addresses/$addressId',
        data: {
          if (country != null) 'country': country,
          if (city != null) 'city': city,
          if (street != null) 'street': street,
          if (buildingNumber != null) 'buildingNumber': buildingNumber,
          if (floor != null) 'floor': floor,
          if (apartment != null) 'apartment': apartment,
          if (latitude != null) 'latitude': latitude,
          if (longitude != null) 'longitude': longitude,
          if (isDefault != null) 'isDefault': isDefault,
        },
      );

      return AddressModel.fromJson(
          response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    try {
      await _apiService.delete('/users/addresses/$addressId');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> setDefaultAddress(String addressId) async {
    try {
      await _apiService.post('/users/addresses/$addressId/default');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<String> uploadProfilePhoto(String filePath) async {
    try {
      final response = await _apiService.uploadFile<Map<String, dynamic>>(
        '/users/upload-photo',
        filePath,
        fieldName: 'photo',
      );

      return response.data!['data']['url'] as String;
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
