import '../../core/error/result.dart';
import '../../domain/entities/address.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../core/storage/storage_keys.dart';
import '../core/storage/storage_service.dart';
import '../core/utils/repository_call_handler.dart';
import '../datasources/remote/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;
  final StorageService _storageService;

  UserRepositoryImpl({
    required UserRemoteDataSource remoteDataSource,
    required StorageService storageService,
  })  : _remoteDataSource = remoteDataSource,
        _storageService = storageService;

  Future<String?> _getUserId() => _storageService.get<String>(StorageKeys.userId);

  @override
  Future<Result<User>> getUserProfile() async {
    return RepositoryCallHandler.callWithAuth<User>(
          _getUserId,
          (userId) async {
        final userModel = await _remoteDataSource.getUserProfile(userId);
        return userModel.toEntity();
      },
    );
  }

  @override
  Future<Result<User>> updateUserProfile({
    String? fullName,
    String? email,
    String? profilePhotoUrl,
  }) async {
    return RepositoryCallHandler.callWithAuth<User>(
          _getUserId,
          (userId) async {
        String? firstName;
        String? lastName;
        if (fullName != null) {
          final names = fullName.split(' ');
          firstName = names.first;
          lastName = names.length > 1 ? names.sublist(1).join(' ') : '';
        }

        final userModel = await _remoteDataSource.updateUserProfile(
          userId: userId,
          firstName: firstName,
          lastName: lastName,
          email: email,
        );

        return userModel.toEntity();
      },
    );
  }

  @override
  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return RepositoryCallHandler.callWithAuth<void>(
          _getUserId,
          (userId) => _remoteDataSource.changePassword(
        userId: userId,
        currentPassword: currentPassword,
        newPassword: newPassword,
      ),
    );
  }

  @override
  Future<Result<Address>> getUserAddress() async {
    return RepositoryCallHandler.callWithAuth<Address>(
          _getUserId,
          (userId) async {
        final addressModel = await _remoteDataSource.getUserAddress(userId);
        return addressModel.toEntity();
      },
    );
  }

  @override
  Future<Result<Address>> addAddress({
    required String country,
    required String city,
  }) async {
    return RepositoryCallHandler.callWithAuth<Address>(
          _getUserId,
          (userId) async {
        final addressModel = await _remoteDataSource.addAddress(
          userId: userId,
          country: country,
          city: city,
        );

        return addressModel.toEntity();
      },
    );
  }

  @override
  Future<Result<Address>> updateAddress({
    required String addressId,
    String? country,
    String? city,
  }) async {
    return RepositoryCallHandler.call<Address>(() async {
      final addressModel = await _remoteDataSource.updateAddress(
        addressId: addressId,
        country: country,
        city: city,
      );

      return addressModel.toEntity();
    });
  }

  @override
  Future<Result<void>> deleteAddress(String addressId) async {
    return RepositoryCallHandler.callVoid(
          () => _remoteDataSource.deleteAddress(addressId),
    );
  }

  @override
  Future<Result<String>> uploadProfilePhoto(String filePath) async {
    return RepositoryCallHandler.callWithAuth<String>(
          _getUserId,
          (userId) => _remoteDataSource.uploadProfilePhoto(
        userId: userId,
        filePath: filePath,
      ),
    );
  }
}