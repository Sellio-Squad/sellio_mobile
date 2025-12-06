import '../../core/error/result.dart';
import '../entities/address.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Result<User>> getUserProfile();

  Future<Result<User>> updateUserProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? country,
    String? city,
    String? avatarUrl,
  });

  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  Future<Result<Address>> getUserAddress();

  Future<Result<Address>> addAddress({
    required String country,
    required String city,
  });

  Future<Result<Address>> updateAddress({
    required String addressId,
    String? country,
    String? city,
  });

  Future<Result<void>> deleteAddress(String addressId);

  Future<Result<String>> uploadProfilePhoto(String filePath);
}
