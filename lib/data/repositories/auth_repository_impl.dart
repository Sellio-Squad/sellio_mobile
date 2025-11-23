import 'package:sellio_mobile/data/mappers/user_mapper.dart';

import '../../core/error/result.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../core/storage/storage_keys.dart';
import '../core/storage/storage_service.dart';
import '../core/utils/repository_call_handler.dart';
import '../datasource/remote/auth/auth_remote.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final StorageService _storageService;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required StorageService storageService,
  })  : _remoteDataSource = remoteDataSource,
        _storageService = storageService;

  @override
  Future<Result<User>> login({
    required String phoneNumber,
    required String countryCode,
    required String password,
  }) async {
    return RepositoryCallHandler.call<User>(() async {
      final userModel = await _remoteDataSource.login(
        phoneNumber: phoneNumber,
        countryCode: countryCode,
        password: password,
      );

      // Save auth data
      // TODO: Update your API response to include token
      // await _storageService.save<String>(StorageKeys.authToken, userModel.token);
      await _storageService.save<bool>(StorageKeys.isLoggedIn, true);

      return userModel.toEntity();
    });
  }

  @override
  Future<Result<User>> register({
    required String fullName,
    required String phoneNumber,
    required String countryCode,
    required String password,
    required String country,
    required String city,
    String? profilePhotoUrl,
  }) async {
    return RepositoryCallHandler.call<User>(() async {
      final names = fullName.split(' ');
      final firstName = names.first;
      final lastName = names.length > 1 ? names.sublist(1).join(' ') : '';

      final userModel = await _remoteDataSource.register(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        countryCode: countryCode,
        password: password,
        country: country,
        city: city,
      );

      await _storageService.save<bool>(StorageKeys.isLoggedIn, true);

      return userModel.toEntity();
    });
  }

  @override
  Future<Result<bool>> verifyOtp({
    required String phoneNumber,
    required String countryCode,
    required String otpCode,
  }) async {
    return RepositoryCallHandler.call<bool>(
          () => _remoteDataSource.verifyOtp(
        phoneNumber: phoneNumber,
        countryCode: countryCode,
        otpCode: otpCode,
      ),
    );
  }

  @override
  Future<Result<void>> resendOtp({
    required String phoneNumber,
    required String countryCode,
  }) async {
    return RepositoryCallHandler.callVoid(
          () => _remoteDataSource.resendOtp(
        phoneNumber: phoneNumber,
        countryCode: countryCode,
      ),
    );
  }

  @override
  Future<Result<void>> sendForgotPasswordOtp({
    required String phoneNumber,
    required String countryCode,
  }) async {
    return RepositoryCallHandler.callVoid(
          () => _remoteDataSource.sendForgotPasswordOtp(
        phoneNumber: phoneNumber,
        countryCode: countryCode,
      ),
    );
  }

  @override
  Future<Result<void>> resetPassword({
    required String phoneNumber,
    required String countryCode,
    required String otpCode,
    required String newPassword,
  }) async {
    return RepositoryCallHandler.callVoid(
          () => _remoteDataSource.resetPassword(
        phoneNumber: phoneNumber,
        countryCode: countryCode,
        otpCode: otpCode,
        newPassword: newPassword,
      ),
    );
  }

  @override
  Future<Result<void>> logout() async {
    return RepositoryCallHandler.callVoid(() async {
      await _storageService.remove(StorageKeys.authToken);
      await _storageService.remove(StorageKeys.refreshToken);
      await _storageService.remove(StorageKeys.userId);
      await _storageService.remove(StorageKeys.isLoggedIn);
    });
  }

  @override
  Future<Result<User?>> getCurrentUser() async {
    return RepositoryCallHandler.call<User?>(() async {
      final userId = await _storageService.get<String>(StorageKeys.userId);
      if (userId == null) return null;

      final userModel = await _remoteDataSource.getCurrentUser(userId);
      return userModel?.toEntity();
    });
  }

  @override
  Future<Result<bool>> isLoggedIn() async {
    return RepositoryCallHandler.call<bool>(() async {
      final token = await _storageService.get<String>(StorageKeys.authToken);
      final userId = await _storageService.get<String>(StorageKeys.userId);
      return token != null && token.isNotEmpty && userId != null;
    });
  }

  @override
  Future<Result<String?>> getAuthToken() async {
    return RepositoryCallHandler.call<String?>(
      () => _storageService.get<String>(StorageKeys.authToken),
    );
  }
}