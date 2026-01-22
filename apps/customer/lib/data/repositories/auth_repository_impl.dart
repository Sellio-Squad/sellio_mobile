import '../../core/error/result.dart';
import '../../domain/repositories/auth_repository.dart';
import '../core/storage/storage_keys.dart';
import '../core/storage/storage_service.dart';
import '../core/utils/repository_call_handler.dart';
import '../datasource/remote/auth/auth_remote_datasource.dart';

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
    });
  }

  @override
  Future<Result<void>> register({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String password,
    required String city,
    required String country,
    required String region,
  }) async {
    return RepositoryCallHandler.callVoid(() async {
      final response = await _remoteDataSource.register(
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        password: password,
        city: city,
        country: country,
        region: region,
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
        StorageKeys.registrationSessionId,
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
  Future<Result<void>> resendRegistrationOtp() async {
    return RepositoryCallHandler.callVoid(() async {
      final sessionId = await _storageService.get<String>(
        StorageKeys.registrationSessionId,
      );

      if (sessionId == null || sessionId.isEmpty) {
        throw Exception('No pending registration found');
      }

      final response = await _remoteDataSource.resendOtp(
        sessionId: sessionId,
      );

      await _storageService.save<String>(
        StorageKeys.registrationSessionId,
        response.sessionId,
      );
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
      
      // Store sessionId for subsequent operations
      await _storageService.save<String>(
        StorageKeys.forgotPasswordSessionId,
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
        StorageKeys.forgotPasswordSessionId,
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
        StorageKeys.forgotPasswordSessionId,
      );

      if (sessionId == null || sessionId.isEmpty) {
        throw Exception('No forgot password session found');
      }

      await _remoteDataSource.resetPassword(
        sessionId: sessionId,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      
      // Clear the session after successful reset
      await _storageService.remove(StorageKeys.forgotPasswordSessionId);
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
    final token = await _storageService.get<String>(StorageKeys.authToken);
    return token != null && token.isNotEmpty;
  }

  @override
  Future<String?> getPendingRegistrationPhone() async {
    return _storageService.get<String>(StorageKeys.registrationPhoneNumber);
  }

  @override
  Future<void> clearPendingRegistration() async {
    await _storageService.remove(StorageKeys.registrationSessionId);
    await _storageService.remove(StorageKeys.registrationPhoneNumber);
  }

  Future<void> _saveAuthTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storageService.save<String>(StorageKeys.authToken, accessToken);
    await _storageService.save<String>(StorageKeys.refreshToken, refreshToken);
    await _storageService.save<bool>(StorageKeys.isLoggedIn, true);
    await _storageService.remove(StorageKeys.isGuestMode);
  }

  Future<void> _savePendingRegistration({
    required String sessionId,
    required String phoneNumber,
  }) async {
    await _storageService.save<String>(
      StorageKeys.registrationSessionId,
      sessionId,
    );
    await _storageService.save<String>(
      StorageKeys.registrationPhoneNumber,
      phoneNumber,
    );
  }

  Future<void> _clearAuthData() async {
    await _storageService.remove(StorageKeys.authToken);
    await _storageService.remove(StorageKeys.refreshToken);
    await _storageService.remove(StorageKeys.isLoggedIn);
    await _storageService.remove(StorageKeys.isGuestMode);
    await clearPendingRegistration();
  }

  @override
  Future<void> clearAuthData() async {
    await _clearAuthData();
  }

  @override
  Future<bool> isGuestMode() async {
    final isGuest = await _storageService.get<bool>(StorageKeys.isGuestMode);
    return isGuest ?? false;
  }

  @override
  Future<Result<void>> loginAsGuest() async {
    return RepositoryCallHandler.callVoid(() async {
      await _clearAuthData();
      await _storageService.save<bool>(StorageKeys.isGuestMode, true);
    });
  }

  @override
  Future<void> clearGuestMode() async {
    await _storageService.remove(StorageKeys.isGuestMode);
  }
}