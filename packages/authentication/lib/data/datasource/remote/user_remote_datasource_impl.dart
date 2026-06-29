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
  final AuthConfiguration _configuration;

  UserRemoteDataSourceImpl(this._httpClient, this._configuration);

  @override
  Future<UserModel> getUserProfile() async {
    final response = await _httpClient.get(_configuration.userProfile());
    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> updateUserProfile(UpdateUserProfileRequest request) async {
    final response = await _httpClient.put(
      _configuration.userUpdate(),
      data: request.toJson(),
    );

    return UserModel.fromJson(response.data);
  }

  @override
  Future<void> changePassword(ChangePasswordRequest request) async {
    await _httpClient.put(
      _configuration.userChangePassword(),
      data: request.toJson(),
    );
  }

  @override
  Future<void> resetPassword(ResetPasswordRequest request) async {
    await _httpClient.post(
      _configuration.resetPassword,
      data: request.toJson(),
    );
  }

  @override
  Future<void> deleteAccount() async {
    await _httpClient.delete(_configuration.userDelete());
  }

  @override
  Future<AddressModel> getUserAddress() async {
    final response = await _httpClient.get(_configuration.userAddress());
    return AddressModel.fromJson(response.data);
  }

  @override
  Future<AddressModel> addAddress(AddAddressRequest request) async {
    final response = await _httpClient.post(
      _configuration.userAddress(),
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
      _configuration.addressById(addressId),
      data: request.toJson(),
    );

    return AddressModel.fromJson(response.data);
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    await _httpClient.delete(_configuration.addressById(addressId));
  }

  @override
  Future<String> uploadProfilePhoto({
    required String filePath,
  }) async {
    final response = await _httpClient.uploadFile(
      _configuration.userAvatar(),
      filePath,
      fieldName: 'image',
    );

    return response.data['avatarUrl'] as String;
  }
}
