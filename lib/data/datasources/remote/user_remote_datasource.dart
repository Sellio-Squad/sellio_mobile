import '../../core/api/api_endpoints.dart';
import '../../core/api/api_client.dart';
import '../../models/user_model.dart';
import '../../models/address_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUserProfile(String userId);

  Future<UserModel> updateUserProfile({
    required String userId,
    String? firstName,
    String? lastName,
    String? email,
  });

  Future<void> changePassword({
    required String userId,
    required String currentPassword,
    required String newPassword,
  });

  Future<AddressModel> getUserAddress(String userId);

  Future<AddressModel> addAddress({
    required String userId,
    required String country,
    required String city,
  });

  Future<AddressModel> updateAddress({
    required String addressId,
    String? country,
    String? city,
  });

  Future<void> deleteAddress(String addressId);

  Future<String> uploadProfilePhoto({
    required String userId,
    required String filePath,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient _httpClient;

  UserRemoteDataSourceImpl(this._httpClient);

  @override
  Future<UserModel> getUserProfile(String userId) async {
    final response = await _httpClient.get(ApiEndpoints.userById(userId));
    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> updateUserProfile({
    required String userId,
    String? firstName,
    String? lastName,
    String? email,
  }) async {
    final response = await _httpClient.put(
      ApiEndpoints.userUpdate(userId),
      data: {
        if (firstName != null) 'firstName': firstName,
        if (lastName != null) 'lastName': lastName,
        if (email != null) 'email': email,
      },
    );

    return UserModel.fromJson(response.data);
  }

  @override
  Future<void> changePassword({
    required String userId,
    required String currentPassword,
    required String newPassword,
  }) async {
    await _httpClient.put(
      ApiEndpoints.userChangePassword(userId),
      data: {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
    );
  }

  @override
  Future<AddressModel> getUserAddress(String userId) async {
    final response = await _httpClient.get(ApiEndpoints.userAddress(userId));
    return AddressModel.fromJson(response.data);
  }

  @override
  Future<AddressModel> addAddress({
    required String userId,
    required String country,
    required String city,
  }) async {
    final response = await _httpClient.post(
      ApiEndpoints.userAddress(userId),
      data: {
        'country': country,
        'city': city,
      },
    );

    return AddressModel.fromJson(response.data);
  }

  @override
  Future<AddressModel> updateAddress({
    required String addressId,
    String? country,
    String? city,
  }) async {
    final response = await _httpClient.put(
      ApiEndpoints.addressById(addressId),
      data: {
        if (country != null) 'country': country,
        if (city != null) 'city': city,
      },
    );

    return AddressModel.fromJson(response.data);
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    await _httpClient.delete(ApiEndpoints.addressById(addressId));
  }

  @override
  Future<String> uploadProfilePhoto({
    required String userId,
    required String filePath,
  }) async {
    final response = await _httpClient.uploadFile(
      ApiEndpoints.userAvatar(userId),
      filePath,
      fieldName: 'image',
    );

    return response.data['avatarUrl'] as String;
  }
}
