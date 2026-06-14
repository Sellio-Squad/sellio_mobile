import 'package:core/error/failure.dart';
import 'package:core/error/result.dart';
import '../exceptions/auth_exception_handler.dart';

class AuthRepositoryCallHandler {
  AuthRepositoryCallHandler._();

  static Future<Result<T>> call<T>(
    Future<T> Function() repositoryCall,
  ) async {
    try {
      final result = await repositoryCall();
      return Success(result);
    } catch (e) {
      return ResultFailure(AuthExceptionHandler.handleException(e));
    }
  }

  static Future<Result<void>> callVoid(
    Future<void> Function() repositoryCall,
  ) async {
    try {
      await repositoryCall();
      return const Success(null);
    } catch (e) {
      return ResultFailure(AuthExceptionHandler.handleException(e));
    }
  }
}
