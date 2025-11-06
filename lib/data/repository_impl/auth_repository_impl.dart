import '../../domain/core/failure.dart';
import '../../domain/core/result.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/user_local_datasource.dart';
import '../datasources/remote/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final UserLocalDataSource _localDataSource;

  AuthRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Result<User>> login({
    required String phoneNumber,
    required String countryCode,
    required String password,
  }) async {
    try {
      final user = await _remoteDataSource.login(
        phoneNumber: phoneNumber,
        countryCode: countryCode,
        password: password,
      );

      // Cache user locally
      await _localDataSource.cacheUser(user);

      return Success(user.toEntity());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
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
    try {
      final user = await _remoteDataSource.register(
        fullName: fullName,
        phoneNumber: phoneNumber,
        countryCode: countryCode,
        password: password,
        country: country,
        city: city,
        profilePhotoUrl: profilePhotoUrl,
      );

      // Cache user locally
      await _localDataSource.cacheUser(user);

      return Success(user.toEntity());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<bool>> verifyOtp({
    required String phoneNumber,
    required String countryCode,
    required String otpCode,
  }) async {
    try {
      final verified = await _remoteDataSource.verifyOtp(
        phoneNumber: phoneNumber,
        countryCode: countryCode,
        otpCode: otpCode,
      );

      return Success(verified);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<void>> resendOtp({
    required String phoneNumber,
    required String countryCode,
  }) async {
    try {
      await _remoteDataSource.resendOtp(
        phoneNumber: phoneNumber,
        countryCode: countryCode,
      );

      return const Success(null);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<void>> sendForgotPasswordOtp({
    required String phoneNumber,
    required String countryCode,
  }) async {
    try {
      await _remoteDataSource.sendForgotPasswordOtp(
        phoneNumber: phoneNumber,
        countryCode: countryCode,
      );

      return const Success(null);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<void>> resetPassword({
    required String phoneNumber,
    required String countryCode,
    required String otpCode,
    required String newPassword,
  }) async {
    try {
      await _remoteDataSource.resetPassword(
        phoneNumber: phoneNumber,
        countryCode: countryCode,
        otpCode: otpCode,
        newPassword: newPassword,
      );

      return const Success(null);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _remoteDataSource.logout();

      // Clear local cache
      await _localDataSource.clearUserCache();
      await _localDataSource.clearAuthToken();

      return const Success(null);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<User?>> getCurrentUser() async {
    try {
      // Try to get from cache first
      final cachedUser = await _localDataSource.getCachedUser();
      if (cachedUser != null) {
        return Success(cachedUser.toEntity());
      }

      // Fetch from remote if not in cache
      final user = await _remoteDataSource.getCurrentUser();
      await _localDataSource.cacheUser(user);

      return Success(user.toEntity());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<bool>> isLoggedIn() async {
    try {
      final token = await _localDataSource.getAuthToken();
      return Success(token != null);
    } catch (e) {
      return const Success(false);
    }
  }

  @override
  Future<Result<String?>> getAuthToken() async {
    try {
      final token = await _localDataSource.getAuthToken();
      return Success(token);
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
      return const AuthenticationFailure();
    } else if (message.contains('Not found')) {
      return const NotFoundFailure();
    } else if (message.contains('Server error')) {
      return ServerFailure(message: message);
    } else {
      return ServerFailure(message: message);
    }
  }
}
