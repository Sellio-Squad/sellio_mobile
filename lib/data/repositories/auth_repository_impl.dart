import 'package:sellio_mobile/data/mappers/auth_tokens_mapper.dart';
import 'package:sellio_mobile/data/mappers/user_mapper.dart';

import '../../core/error/result.dart';
import '../../domain/entities/auth_tokens.dart';
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
  Future<Result<AuthTokens>> login({
    required String phoneNumber,
    required String countryCode,
    required String password,
  }) async {
    return RepositoryCallHandler.call<AuthTokens>(() async {
      final response = await _remoteDataSource.login(
        phoneNumber: phoneNumber,
        countryCode: countryCode,
        password: password,
      );

      final authTokens = response.toEntity();

      // Save tokens
      await _storageService.save<String>(StorageKeys.authToken, authTokens.accessToken);
      await _storageService.save<String>(StorageKeys.refreshToken, authTokens.refreshToken);
      await _storageService.save<bool>(StorageKeys.isLoggedIn, true);

      // Save user ID if available
      if (response.user != null) {
        // Extract userId from user data if available, or use phoneNumber as identifier
        // Adjust based on your API response structure
        await _storageService.save<String>(StorageKeys.userId, response.user!.phoneNumber);
      }

      return authTokens;
    });
  }

  @override
  Future<Result<String>> register({
    required String fullName,
    required String phoneNumber,
    required String countryCode,
    required String password,
    required String country,
    required String city,
    required String region,
    String? profilePhotoUrl,
  }) async {
    return RepositoryCallHandler.call<String>(() async {
      final names = fullName.split(' ');
      final firstName = names.first;
      final lastName = names.length > 1 ? names.sublist(1).join(' ') : '';

      final response = await _remoteDataSource.register(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        countryCode: countryCode,
        password: password,
        country: country,
        city: city,
        region: region,
      );

      // Return sessionId - don't save tokens yet (wait for OTP verification)
      return response.sessionId;
    });
  }

  @override
  Future<Result<AuthTokens>> verifyOtp({
    required String sessionId,
    required String otp,
  }) async {
    return RepositoryCallHandler.call<AuthTokens>(() async {
      final response = await _remoteDataSource.verifyOtp(
        sessionId: sessionId,
        otp: otp,
      );

      final authTokens = response.toEntity();

      // Save tokens
      await _storageService.save<String>(StorageKeys.authToken, authTokens.accessToken);
      await _storageService.save<String>(StorageKeys.refreshToken, authTokens.refreshToken);
      await _storageService.save<bool>(StorageKeys.isLoggedIn, true);

      // Save user ID if available
      if (response.user != null) {
        await _storageService.save<String>(StorageKeys.userId, response.user!.phoneNumber);
      }

      return authTokens;
    });
  }

  @override
  Future<Result<void>> resendOtp({
    required String sessionId,
  }) async {
    return RepositoryCallHandler.callVoid(
          () => _remoteDataSource.resendOtp(
        sessionId: sessionId,
      ),
    );
  }

  @override
  Future<Result<String>> sendForgotPasswordOtp({
    required String phoneNumber,
    required String defaultRegion,
  }) async {
    return RepositoryCallHandler.call<String>(
          () => _remoteDataSource.sendForgotPasswordOtp(
        phoneNumber: phoneNumber,
        defaultRegion: defaultRegion,
      ),
    );
  }
  
    @override
  Future<Result<void>> verifyForgotPasswordOtp({
    required String sessionId,
    required String otp,
  }) async {
    return RepositoryCallHandler.callVoid(
          () => _remoteDataSource.verifyForgotPasswordOtp(
        sessionId: sessionId,
        otp: otp,
      ),
    );
  }

  @override
  Future<Result<void>> resetPassword({
    required String sessionId,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return RepositoryCallHandler.callVoid(
          () => _remoteDataSource.resetPassword(
        sessionId: sessionId,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
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
