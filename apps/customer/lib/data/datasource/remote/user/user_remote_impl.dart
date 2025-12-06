
import 'package:sellio_mobile/data/datasource/remote/user/user_remote.dart';

import '../../../core/api/api_endpoints.dart';
import '../../../core/api/api_client.dart';
import '../../../models/user_model.dart';
import '../../../models/address_model.dart';
import '../../../models/request/update_user_profile_request.dart';
import '../../../models/request/change_password_request.dart';
import '../../../models/request/add_address_request.dart';
import '../../../models/request/update_address_request.dart';


class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient _httpClient;

  UserRemoteDataSourceImpl(this._httpClient);

  @override
  Future<UserModel> getUserProfile() async {
    final response = await _httpClient.get(ApiEndpoints.userProfile());
    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> updateUserProfile(UpdateUserProfileRequest request) async {
    final response = await _httpClient.put(
      ApiEndpoints.userUpdate(),
      data: request.toJson(),
    );

    return UserModel.fromJson(response.data);
  }

  @override
  Future<void> changePassword(ChangePasswordRequest request) async {
    await _httpClient.put(
      ApiEndpoints.userChangePassword(),
      data: request.toJson(),
    );
  }

  @override
  Future<AddressModel> getUserAddress() async {
    final response = await _httpClient.get(ApiEndpoints.userAddress());
    return AddressModel.fromJson(response.data);
  }

  @override
  Future<AddressModel> addAddress(AddAddressRequest request) async {
    final response = await _httpClient.post(
      ApiEndpoints.userAddress(),
      data: request.toJson(),
    );

    return AddressModel.fromJson(response.data);
  }

  @override
  Future<AddressModel> updateAddress({
    required String addressId,
    required UpdateAddressRequest request,
  }) async {
    final response = await _httpClient.put(
      ApiEndpoints.addressById(addressId),
      data: request.toJson(),
    );

    return AddressModel.fromJson(response.data);
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    await _httpClient.delete(ApiEndpoints.addressById(addressId));
  }

  @override
  Future<String> uploadProfilePhoto({
    required String filePath,
  }) async {
    final response = await _httpClient.uploadFile(
      ApiEndpoints.userAvatar(),
      filePath,
      fieldName: 'image',
    );

    return response.data['avatarUrl'] as String;
  }
}
