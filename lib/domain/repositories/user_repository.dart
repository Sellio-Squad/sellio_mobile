import '../entities/user.dart';
import '../entities/address.dart';

abstract class UserRepository {
  /// Get user profile
  Future<User> getUserProfile();

  /// Update user profile
  Future<User> updateUserProfile({
    String? fullName,
    String? email,
    String? profilePhotoUrl,
  });

  /// Change password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  /// Get user addresses
  Future<List<Address>> getUserAddresses();

  /// Add new address
  Future<Address> addAddress({
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
  Future<Address> updateAddress({
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
  Future<void> deleteAddress(String addressId);

  /// Set default address
  Future<void> setDefaultAddress(String addressId);

  /// Upload profile photo
  Future<String> uploadProfilePhoto(String filePath);
}