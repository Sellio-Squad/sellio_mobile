import 'package:core/core.dart';
import '../../models/user/add_address_request.dart';
import '../../models/user/address_model.dart';
import '../../models/user/change_password_request.dart';
import '../../models/user/reset_password_request.dart';
import '../../models/user/update_address_request.dart';
import '../../models/user/update_user_profile_request.dart';
import '../../models/user/user_model.dart';
import 'auth_endpoints.dart';
import 'user_remote_datasource.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient _httpClient;
  final AuthEndpoints _endpoints;

  UserRemoteDataSourceImpl(this._httpClient, this._endpoints);

  @override
  Future<UserModel> getUserProfile() async {
    final response = await _httpClient.get(_endpoints.userProfile());
    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> updateUserProfile(UpdateUserProfileRequest request) async {
    final response = await _httpClient.put(
      _endpoints.userUpdate(),
      data: request.toJson(),
    );

    return UserModel.fromJson(response.data);
  }

  @override
  Future<void> changePassword(ChangePasswordRequest request) async {
    await _httpClient.put(
      _endpoints.userChangePassword(),
      data: request.toJson(),
    );
  }

  @override
  Future<void> resetPassword(ResetPasswordRequest request) async {
    await _httpClient.post(
      _endpoints.resetPassword,
      data: request.toJson(),
    );
  }

  @override
  Future<void> deleteAccount() async {
    await _httpClient.delete(_endpoints.userDelete());
  }

  @override
  Future<AddressModel> getUserAddress() async {
    final response = await _httpClient.get(_endpoints.userAddress());
    return AddressModel.fromJson(response.data);
  }

  @override
  Future<AddressModel> addAddress(AddAddressRequest request) async {
    final response = await _httpClient.post(
      _endpoints.userAddress(),
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
      _endpoints.addressById(addressId),
      data: request.toJson(),
    );

    return AddressModel.fromJson(response.data);
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    await _httpClient.delete(_endpoints.addressById(addressId));
  }

  @override
  Future<String> uploadProfilePhoto({
    required String filePath,
  }) async {
    final response = await _httpClient.uploadFile(
      _endpoints.userAvatar(),
      filePath,
      fieldName: 'image',
    );

    return response.data['avatarUrl'] as String;
  }
}
