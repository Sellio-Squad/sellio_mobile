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

  // ---------------------------------------------------------------------------
  @override
  Future<Result<User>> getUserProfile() async {
    await _simulateDelay();
    return Success(_currentUser);
  }

  // ---------------------------------------------------------------------------
  @override
  Future<Result<User>> updateUserProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? country,
    String? city,
    String? avatarUrl,
  }) async {
    await _simulateDelay();

    Address updatedAddress = _currentUser.address.copyWith(
      country: country ?? _currentUser.address.country,
      city: city ?? _currentUser.address.city,
    );

    _currentUser = _currentUser.copyWith(
      firstName: firstName ?? _currentUser.firstName,
      lastName: lastName ?? _currentUser.lastName,
      email: email ?? _currentUser.email,
      phoneNumber: phoneNumber ?? _currentUser.phoneNumber,
      avatarUrl: avatarUrl ?? _currentUser.avatarUrl,
      address: updatedAddress,
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

  // ---------------------------------------------------------------------------
  @override
  Future<Result<Address>> getUserAddress() async {
    await _simulateDelay();
    return Success(_currentUser.address);
  }

  // ---------------------------------------------------------------------------
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

    // Also update current user's primary address
    _currentUser = _currentUser.copyWith(address: newAddress);

    return Success(newAddress);
  }

  // ---------------------------------------------------------------------------
  @override
  Future<Result<Address>> updateAddress({
    required String addressId,
    String? country,
    String? city,
  }) async {
    await _simulateDelay();

    final index = _addresses.indexWhere((a) => a.id == addressId);
    if (index == -1) {
      return const ResultFailure(
        NotFoundFailure(message: 'Address not found'),
      );
    }

    final updated = _addresses[index].copyWith(
      country: country,
      city: city,
    );

    _addresses[index] = updated;

    // If this is the user's active address → update user
    if (_currentUser.address.id == addressId) {
      _currentUser = _currentUser.copyWith(address: updated);
    }

    return Success(updated);
  }

  // ---------------------------------------------------------------------------
  @override
  Future<Result<void>> deleteAddress(String addressId) async {
    await _simulateDelay();

    _addresses.removeWhere((a) => a.id == addressId);

    // If deleting the user's active address → clear it or replace it
    if (_currentUser.address.id == addressId) {
      _currentUser = _currentUser.copyWith(
        address: Address(id: '', country: '', city: ''),
      );
    }

    return const Success(null);
  }

  // ---------------------------------------------------------------------------
  @override
  Future<Result<String>> uploadProfilePhoto(String filePath) async {
    await _simulateDelay();

    if (filePath.isEmpty) {
      return const ResultFailure(
        ValidationFailure(message: 'File path cannot be empty'),
      );
    }

    final photoUrl =
        'https://i.pravatar.cc/150?random=${DateTime.now().millisecondsSinceEpoch}';

    _currentUser = _currentUser.copyWith(avatarUrl: photoUrl);

    return Success(photoUrl);
  }
}
