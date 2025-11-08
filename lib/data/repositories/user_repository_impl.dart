import '../../domain/entities/user.dart';
import '../../domain/entities/address.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  // Mock user data
  User _mockUser = const User(
    id: 'user1',
    fullName: 'John Doe',
    phoneNumber: '1234567890',
    countryCode: '+1',
    profilePhotoUrl: 'https://i.pravatar.cc/200?img=1',
    address: Address(
      id: 'addr1',
      country: 'United States',
      city: 'New York',
      latitude: 40.7128,
      longitude: -74.0060,
    ),
  );

  Address _mockAddress = const Address(
    id: 'addr1',
    country: 'United States',
    city: 'New York',
    latitude: 40.7128,
    longitude: -74.0060,
  );

  @override
  Future<User> getUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockUser;
  }

  @override
  Future<User> updateUserProfile({
    String? fullName,
    String? email,
    String? profilePhotoUrl,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    _mockUser = _mockUser.copyWith(
      fullName: fullName,
      profilePhotoUrl: profilePhotoUrl,
    );

    return _mockUser;
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Mock password change validation
    if (currentPassword == 'wrongpassword') {
      throw Exception('Current password is incorrect');
    }

    if (newPassword.length < 6) {
      throw Exception('New password must be at least 6 characters');
    }

    // Success - no return value needed
  }

  @override
  Future<Address> getUserAddress() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockAddress;
  }

  @override
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
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final newAddress = Address(
      id: 'addr_${DateTime.now().millisecondsSinceEpoch}',
      country: country,
      city: city,
      latitude: latitude,
      longitude: longitude,
    );

    if (isDefault) {
      _mockAddress = newAddress;
      // Update user with new address
      _mockUser = _mockUser.copyWith(address: newAddress);
    }

    return newAddress;
  }

  @override
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
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    if (_mockAddress.id != addressId) {
      throw Exception('Address not found');
    }

    _mockAddress = _mockAddress.copyWith(
      country: country,
      city: city,
      latitude: latitude,
      longitude: longitude,
    );

    // Update user with updated address
    _mockUser = _mockUser.copyWith(address: _mockAddress);

    return _mockAddress;
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    await Future.delayed(const Duration(milliseconds: 400));

    if (_mockAddress.id != addressId) {
      throw Exception('Address not found');
    }

    // In a real app, you'd remove from a list
    // For mock, reset to a default address
    _mockAddress = const Address(
      id: 'default_addr',
      country: 'United States',
      city: 'New York',
    );
  }

  @override
  Future<void> setDefaultAddress(String addressId) async {
    await Future.delayed(const Duration(milliseconds: 400));

    if (_mockAddress.id == addressId) {
      _mockAddress = _mockAddress;
      _mockUser = _mockUser.copyWith(address: _mockAddress);
    }
  }

  @override
  Future<String> uploadProfilePhoto(String filePath) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    // Mock file upload - return a fake URL
    final photoUrl = 'https://i.pravatar.cc/200?img=${DateTime.now().millisecondsSinceEpoch % 70}';

    // Update user profile with new photo
    _mockUser = _mockUser.copyWith(profilePhotoUrl: photoUrl);

    return photoUrl;
  }
}