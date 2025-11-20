import '../../../core/error/failure.dart';
import '../../../core/error/result.dart';
import '../../../domain/entities/address.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../mock/mock_data_generator.dart';

class MockUserRepositoryImpl implements UserRepository {
  User _currentUser = MockDataGenerator.generateUser(index: 0);
  final List<Address> _addresses = MockDataGenerator.generateAddresses(count: 2);

  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<Result<User>> getUserProfile() async {
    await _simulateDelay();
    return Success(_currentUser);
  }

  @override
  Future<Result<User>> updateUserProfile({
    String? fullName,
    String? email,
    String? profilePhotoUrl,
  }) async {
    await _simulateDelay();

    _currentUser = _currentUser.copyWith(
      fullName: fullName ?? _currentUser.fullName,
      profilePhotoUrl: profilePhotoUrl ?? _currentUser.profilePhotoUrl,
    );

    return Success(_currentUser);
  }

  @override
  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await _simulateDelay();

    if (currentPassword.isEmpty || newPassword.isEmpty) {
      return const ResultFailure(
        ValidationFailure(message: 'Passwords cannot be empty'),
      );
    }

    if (newPassword.length < 6) {
      return const ResultFailure(
        ValidationFailure(message: 'Password must be at least 6 characters'),
      );
    }

    return const Success(null);
  }

  @override
  Future<Result<Address>> getUserAddress() async {
    await _simulateDelay();
    return Success(_currentUser.address);
  }

  // Continuing from MockUserRepositoryImpl addAddress method

  @override
  Future<Result<Address>> addAddress({
    required String country,
    required String city,
  }) async {
    await _simulateDelay();

    final newAddress = Address(
      id: 'address_${DateTime.now().millisecondsSinceEpoch}',
      country: country,
      city: city,
    );

    _addresses.add(newAddress);
    return Success(newAddress);
  }

  @override
  Future<Result<Address>> updateAddress({
    required String addressId,
    String? country,
    String? city,
  }) async {
    await _simulateDelay();

    final addressIndex = _addresses.indexWhere((a) => a.id == addressId);

    if (addressIndex == -1) {
      return const ResultFailure(
        NotFoundFailure(message: 'Address not found'),
      );
    }

    final updatedAddress = _addresses[addressIndex].copyWith(
      country: country ?? _addresses[addressIndex].country,
      city: city ?? _addresses[addressIndex].city,
    );

    _addresses[addressIndex] = updatedAddress;

    // Update user's address if it's the same one
    if (_currentUser.address.id == addressId) {
      _currentUser = _currentUser.copyWith(address: updatedAddress);
    }

    return Success(updatedAddress);
  }

  @override
  Future<Result<void>> deleteAddress(String addressId) async {
    await _simulateDelay();

     _addresses.removeWhere((a) => a.id == addressId);

    return const Success(null);
  }

  @override
  Future<Result<String>> uploadProfilePhoto(String filePath) async {
    await _simulateDelay();

    if (filePath.isEmpty) {
      return const ResultFailure(
        ValidationFailure(message: 'File path cannot be empty'),
      );
    }

    // Simulate upload and return a URL
    final photoUrl = 'https://i.pravatar.cc/150?random=${DateTime.now().millisecondsSinceEpoch}';

    _currentUser = _currentUser.copyWith(profilePhotoUrl: photoUrl);

    return Success(photoUrl);
  }
}