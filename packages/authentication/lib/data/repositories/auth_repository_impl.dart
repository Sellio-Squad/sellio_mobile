import 'package:core/core.dart';
import '../../core/storage/auth_storage_keys.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/remote/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final StorageService _storageService;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required StorageService storageService,
  })  : _remoteDataSource = remoteDataSource,
        _storageService = storageService;

  @override
  Future<Result<void>> login({
    required String phoneNumber,
    required String password,
  }) async {
    return RepositoryCallHandler.callVoid(() async {
      final response = await _remoteDataSource.login(
        phoneNumber: phoneNumber,
        password: password,
      );

      await _saveAuthTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      await _storageService.save<bool>(AuthStorageKeys.isGuestMode, false);
    });
  }

  @override
  Future<Result<void>> register({
    required String fullName,
    required String phoneNumber,
    required String password,
    required String city,
    required String country,
    required String region,
    required String countryCode,
  }) async {
    return RepositoryCallHandler.callVoid(() async {
      final response = await _remoteDataSource.register(
        fullName: fullName,
        phoneNumber: phoneNumber,
        password: password,
        city: city,
        country: country,
        region: region,
        countryCode: countryCode,
      );

      await _savePendingRegistration(
        sessionId: response.sessionId,
        phoneNumber: phoneNumber,
      );
    });
  }

  @override
  Future<Result<void>> verifyRegistrationOtp({
    required String otp,
  }) async {
    return RepositoryCallHandler.callVoid(() async {
      final sessionId = await _storageService.get<String>(
        AuthStorageKeys.registrationSessionId,
      );

      if (sessionId == null || sessionId.isEmpty) {
        throw Exception('No pending registration found');
      }

      final response = await _remoteDataSource.verifyOtp(
        otp: otp,
        sessionId: sessionId,
      );

      await _saveAuthTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );

      await clearPendingRegistration();
    });
  }

  @override
  Future<Result<String?>> resendOtp() async {
    return RepositoryCallHandler.call<String?>(() async {
      final sessionId = await _storageService.get<String>(
        AuthStorageKeys.registrationSessionId,
      );

      if (sessionId == null || sessionId.isEmpty) {
        throw Exception('No pending registration found');
      }

      final response = await _remoteDataSource.resendOtp(
        sessionId: sessionId,
      );

      await _storageService.save<String>(
        AuthStorageKeys.registrationSessionId,
        response.sessionId,
      );

      return response.message;
    });
  }

  @override
  Future<Result<void>> sendForgotPasswordOtp({
    required String phoneNumber,
    required String defaultRegion,
  }) async {
    return RepositoryCallHandler.callVoid(() async {
      final response = await _remoteDataSource.sendForgotPasswordOtp(
        phoneNumber: phoneNumber,
        defaultRegion: defaultRegion,
      );

      await _storageService.save<String>(
        AuthStorageKeys.forgotPasswordSessionId,
        response.sessionId,
      );
    });
  }

  @override
  Future<Result<void>> verifyForgotPasswordOtp({
    required String otp,
  }) async {
    return RepositoryCallHandler.callVoid(() async {
      final sessionId = await _storageService.get<String>(
        AuthStorageKeys.forgotPasswordSessionId,
      );

      if (sessionId == null || sessionId.isEmpty) {
        throw Exception('No forgot password session found');
      }

      await _remoteDataSource.verifyForgotPasswordOtp(
        otp: otp,
        sessionId: sessionId,
      );
    });
  }

  @override
  Future<Result<void>> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    return RepositoryCallHandler.callVoid(() async {
      final sessionId = await _storageService.get<String>(
        AuthStorageKeys.forgotPasswordSessionId,
      );

      if (sessionId == null || sessionId.isEmpty) {
        throw Exception('No forgot password session found');
      }

      await _remoteDataSource.resetPassword(
        sessionId: sessionId,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      await _storageService.remove(AuthStorageKeys.forgotPasswordSessionId);
    });
  }

  @override
  Future<Result<void>> logout() async {
    return RepositoryCallHandler.callVoid(() async {
      await _clearAuthData();
    });
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = await _storageService.get<String>(AuthStorageKeys.authToken);
    return token != null && token.isNotEmpty;
  }

  @override
  Future<String?> getPendingRegistrationPhone() async {
    return _storageService.get<String>(AuthStorageKeys.registrationPhoneNumber);
  }

  @override
  Future<void> clearPendingRegistration() async {
    await _storageService.remove(AuthStorageKeys.registrationSessionId);
    await _storageService.remove(AuthStorageKeys.registrationPhoneNumber);
  }

  Future<void> _saveAuthTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storageService.save<String>(AuthStorageKeys.authToken, accessToken);
    await _storageService.save<String>(AuthStorageKeys.refreshToken, refreshToken);
    await _storageService.save<bool>(AuthStorageKeys.isLoggedIn, true);
    await _storageService.remove(AuthStorageKeys.isGuestMode);
  }

  Future<void> _savePendingRegistration({
    required String sessionId,
    required String phoneNumber,
  }) async {
    await _storageService.save<String>(
      AuthStorageKeys.registrationSessionId,
      sessionId,
    );
    await _storageService.save<String>(
      AuthStorageKeys.registrationPhoneNumber,
      phoneNumber,
    );
  }

  Future<void> _clearAuthData() async {
    await _storageService.remove(AuthStorageKeys.authToken);
    await _storageService.remove(AuthStorageKeys.refreshToken);
    await _storageService.remove(AuthStorageKeys.isLoggedIn);
    await _storageService.remove(AuthStorageKeys.isGuestMode);
    await clearPendingRegistration();
  }

  @override
  Future<void> clearAuthData() async {
    await _clearAuthData();
  }

  @override
  Future<bool> isGuestMode() async {
    return await _storageService.get<bool>(AuthStorageKeys.isGuestMode) ?? true;
  }

  @override
  Future<Result<void>> loginAsGuest() async {
    return RepositoryCallHandler.callVoid(() async {
      await _clearAuthData();
      await _storageService.save<bool>(AuthStorageKeys.isGuestMode, true);
    });
  }

  @override
  Future<void> clearGuestMode() async {
    await _storageService.remove(AuthStorageKeys.isGuestMode);
  }
}
