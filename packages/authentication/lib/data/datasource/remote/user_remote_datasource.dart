import '../../models/user/add_address_request.dart';
import '../../models/user/address_model.dart';
import '../../models/user/change_password_request.dart';
import '../../models/user/reset_password_request.dart';
import '../../models/user/update_address_request.dart';
import '../../models/user/update_user_profile_request.dart';
import '../../models/user/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUserProfile();

  Future<UserModel> updateUserProfile(UpdateUserProfileRequest request);

  Future<void> changePassword(ChangePasswordRequest request);

  Future<void> resetPassword(ResetPasswordRequest request);

  Future<void> deleteAccount();

  Future<AddressModel> getUserAddress();

  Future<AddressModel> addAddress(AddAddressRequest request);

  Future<AddressModel> updateAddress({
    required String addressId,
    required UpdateAddressRequest request,
  });

  Future<void> deleteAddress(String addressId);

  Future<String> uploadProfilePhoto({
    required String filePath,
  });
}
