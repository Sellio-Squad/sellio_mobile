import '../../domain/core/failure.dart';
import '../../domain/core/result.dart';
import '../../domain/entities/address.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/local/user_local_datasource.dart';
import '../datasources/remote/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;
  final UserLocalDataSource _localDataSource;

  UserRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Result<User>> getUserProfile() async {
    try {
      final user = await _remoteDataSource.getUserProfile();

      // Cache user
      await _localDataSource.cacheUser(user);

      return Success(user.toEntity());
    } catch (e) {
      // Try to get from cache
      try {
        final cachedUser = await _localDataSource.getCachedUser();
        if (cachedUser != null) {
          return Success(cachedUser.toEntity());
        }
      } catch (cacheError) {
        // Cache failed
      }

      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<User>> updateUserProfile({
    String? fullName,
    String? email,
    String? profilePhotoUrl,
  }) async {
    try {
      final user = await _remoteDataSource.updateUserProfile(
        fullName: fullName,
        email: email,
        profilePhotoUrl: profilePhotoUrl,
      );

      // Cache updated user
      await _localDataSource.cacheUser(user);

      return Success(user.toEntity());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _remoteDataSource.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      return const Success(null);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<List<Address>>> getUserAddresses() async {
    try {
      final addresses = await _remoteDataSource.getUserAddresses();
      return Success(addresses.map((model) => model.toEntity()).toList());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
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
  }) async {
    try {
      final address = await _remoteDataSource.addAddress(
        country: country,
        city: city,
        street: street,
        buildingNumber: buildingNumber,
        floor: floor,
        apartment: apartment,
        latitude: latitude,
        longitude: longitude,
        isDefault: isDefault,
      );

      return Success(address.toEntity());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
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
  }) async {
    try {
      final address = await _remoteDataSource.updateAddress(
        addressId: addressId,
        country: country,
        city: city,
        street: street,
        buildingNumber: buildingNumber,
        floor: floor,
        apartment: apartment,
        latitude: latitude,
        longitude: longitude,
        isDefault: isDefault,
      );

      return Success(address.toEntity());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<void>> deleteAddress(String addressId) async {
    try {
      await _remoteDataSource.deleteAddress(addressId);
      return const Success(null);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<void>> setDefaultAddress(String addressId) async {
    try {
      await _remoteDataSource.setDefaultAddress(addressId);
      return const Success(null);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<String>> uploadProfilePhoto(String filePath) async {
    try {
      final url = await _remoteDataSource.uploadProfilePhoto(filePath);
      return Success(url);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  Failure _mapExceptionToFailure(Object e) {
    final message = e.toString();

    if (message.contains('No internet connection') ||
        message.contains('Connection timeout')) {
      return const NetworkFailure();
    } else if (message.contains('Unauthorized')) {
      return const UnauthorizedFailure();
    } else if (message.contains('Not found')) {
      return const NotFoundFailure();
    } else if (message.contains('Server error')) {
      return ServerFailure(message: message);
    } else {
      return ServerFailure(message: message);
    }
  }
}
