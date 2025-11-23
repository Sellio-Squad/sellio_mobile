import 'package:sellio_mobile/data/mappers/address_mapper.dart';
import 'package:sellio_mobile/data/mappers/user_mapper.dart';

import '../../core/error/result.dart';
import '../../domain/entities/address.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../core/utils/repository_call_handler.dart';
import '../datasource/remote/user/user_remote.dart';
import '../models/requests/update_user_profile_request.dart';
import '../models/requests/change_password_request.dart';
import '../models/requests/add_address_request.dart';
import '../models/requests/update_address_request.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImpl({
    required UserRemoteDataSource remoteDataSource,
  })  : _remoteDataSource = remoteDataSource;

  @override
  Future<Result<User>> getUserProfile() async {
    return RepositoryCallHandler.call<User>(() async {
      final userModel = await _remoteDataSource.getUserProfile();
      return userModel.toEntity();
    });
  }

  @override
  Future<Result<User>> updateUserProfile({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? city,
    String? country,
    String? avatarUrl,
  }) async {
    return RepositoryCallHandler.call<User>(() async {
      final request = UpdateUserProfileRequest(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        city: city,
        country: country,
        avatarUrl: avatarUrl,
      );

      final userModel = await _remoteDataSource.updateUserProfile(request);
      return userModel.toEntity();
    });
  }

  @override
  Future<Result<void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    return RepositoryCallHandler.callVoid(() async {
      final request = ChangePasswordRequest(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      await _remoteDataSource.changePassword(request);
    });
  }

  @override
  Future<Result<Address>> getUserAddress() async {
    return RepositoryCallHandler.call<Address>(() async {
      final model = await _remoteDataSource.getUserAddress();
      return model.toEntity();
    });
  }

  @override
  Future<Result<Address>> addAddress({
    required String country,
    required String city,
  }) async {
    return RepositoryCallHandler.call<Address>(() async {
      final request = AddAddressRequest(
        country: country,
        city: city,
      );

      final model = await _remoteDataSource.addAddress(request);
      return model.toEntity();
    });
  }

  @override
  Future<Result<Address>> updateAddress({
    required String addressId,
    String? country,
    String? city,
  }) async {
    return RepositoryCallHandler.call<Address>(() async {
      final request = UpdateAddressRequest(
        country: country,
        city: city,
      );

      final model = await _remoteDataSource.updateAddress(
        addressId: addressId,
        request: request,
      );

      return model.toEntity();
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
    return RepositoryCallHandler.call<String>(() async {
      return await _remoteDataSource.uploadProfilePhoto(filePath: filePath);
    });
  }
}
