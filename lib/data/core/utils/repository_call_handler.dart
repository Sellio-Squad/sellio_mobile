import '../../../core/error/failure.dart';
import '../../../core/error/result.dart';
import '../exceptions/exception_handler.dart';


class RepositoryCallHandler {
  RepositoryCallHandler._();

  static Future<Result<T>> call<T>(
      Future<T> Function() repositoryCall,
      ) async {
    try {
      final result = await repositoryCall();
      return Success(result);
    } catch (e) {
      return ResultFailure(ExceptionHandler.handleException(e));
    }
  }

  static Future<Result<T>> callWithMapping<T>(
      Future<T> Function() repositoryCall, {
        Failure Function(dynamic error)? errorMapper,
      }) async {
    try {
      final result = await repositoryCall();
      return Success(result);
    } catch (e) {
      if (errorMapper != null) {
        return ResultFailure(errorMapper(e));
      }
      return ResultFailure(ExceptionHandler.handleException(e));
    }
  }

  static Future<Result<void>> callVoid(
      Future<void> Function() repositoryCall,
      ) async {
    try {
      await repositoryCall();
      return const Success(null);
    } catch (e) {
      return ResultFailure(ExceptionHandler.handleException(e));
    }
  }

  static Future<Result<T>> callWithAuth<T>(
      Future<String?> Function() getUserId,
      Future<T> Function(String userId) repositoryCall,
      ) async {
    try {
      final userId = await getUserId();
      if (userId == null) {
        return ResultFailure(
          const AuthenticationFailure(message: 'User not logged in'),
        );
      }

      final result = await repositoryCall(userId);
      return Success(result);
    } catch (e) {
      return ResultFailure(ExceptionHandler.handleException(e));
    }
  }

  static Future<Result<List<T>>> callMultiple<T>(
      List<Future<T> Function()> repositoryCalls,
      ) async {
    try {
      final results = await Future.wait(
        repositoryCalls.map((call) => call()),
      );
      return Success(results);
    } catch (e) {
      return ResultFailure(ExceptionHandler.handleException(e));
    }
  }
}