import '../core/result.dart';
import '../entities/address.dart';
import '../entities/user.dart';

abstract class UserRepository {
  /// Get user profile
  Future<Result<User>> getUserProfile();

  /// Update user profile
  Future<Result<User>> updateUserProfile({
    String? fullName,
    String? email,
    String? profilePhotoUrl,
  });

  /// Change password
  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  /// Get user addresses
  Future<Result<Address>> getUserAddress();

  /// Add new address
  Future<Result<Address>> addAddress({
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

  /// Update address
  Future<Result<Address>> updateAddress({
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

  /// Delete address
  Future<Result<void>> deleteAddress(String addressId);

  /// Set default address
  Future<Result<void>> setDefaultAddress(String addressId);

  /// Upload profile photo
  Future<Result<String>> uploadProfilePhoto(String filePath);
}