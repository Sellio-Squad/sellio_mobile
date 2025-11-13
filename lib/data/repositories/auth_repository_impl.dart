import '../../core/error/result.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../core/storage/auth/auth_storage.dart';
import '../core/utils/repository_call_handler.dart';
import '../datasources/remote/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthStorage _authStorage;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthStorage authStorage,
  })  : _remoteDataSource = remoteDataSource,
        _authStorage = authStorage;

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

      // TODO: Save token
      // TODO: Update UserModel to include token or create AuthResponse
      await _authStorage.saveUserId(userModel.id);

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

      await _authStorage.saveUserId(userModel.id);
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
    return RepositoryCallHandler.callVoid(
          () => _authStorage.clearAll(),
    );
  }

  @override
  Future<Result<User?>> getCurrentUser() async {
    return RepositoryCallHandler.call<User?>(() async {
      final userId = await _authStorage.getUserId();
      if (userId == null) return null;

      final userModel = await _remoteDataSource.getCurrentUser(userId);
      return userModel?.toEntity();
    });
  }

  @override
  Future<Result<bool>> isLoggedIn() async {
    return RepositoryCallHandler.call<bool>(() async {
      return await _authStorage.hasValidSession();
    });
  }

  @override
  Future<Result<String?>> getAuthToken() async {
    return RepositoryCallHandler.call<String?>(
          () => _authStorage.getToken(),
    );
  }
}