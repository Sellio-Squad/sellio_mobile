import 'package:sellio_mobile/data/mappers/user_mapper.dart';

import '../../core/error/result.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../core/utils/repository_call_handler.dart';
import '../datasource/remote/user/user_remote.dart';
import '../models/request/change_password_request.dart';
import '../models/request/reset_password_request.dart';
import '../models/request/update_user_profile_request.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImpl({
    required UserRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Result<User>> getUserProfile() async {
    return RepositoryCallHandler.call<User>(() async {
      final userModel = await _remoteDataSource.getUserProfile();
      return userModel.toEntity();
    });
  }

  @override
  Future<Result<User>> updateUserProfile({
    String? fullName,
    String? phoneNumber,
    String? city,
    String? country,
    String? avatarUrl,
  }) async {
    return RepositoryCallHandler.call<User>(() async {
      final request = UpdateUserProfileRequest(
        fullName: fullName,
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
  Future<Result<void>> resetPassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return RepositoryCallHandler.callVoid(() async {
      final request = ResetPasswordRequest(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      await _remoteDataSource.resetPassword(request);
    });
  }

  @override
  Future<Result<void>> deleteAccount() async {
    return RepositoryCallHandler.callVoid(() async {
      await _remoteDataSource.deleteAccount();
    });
  }

  @override
  Future<Result<String>> uploadProfilePhoto(String filePath) async {
    return RepositoryCallHandler.call<String>(() async {
      return await _remoteDataSource.uploadProfilePhoto(filePath: filePath);
    });
  }
}
