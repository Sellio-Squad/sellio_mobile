import 'package:dio/dio.dart';
import '../../../domain/core/failure.dart';
import 'api_exception.dart';

class ExceptionHandler {
  static Failure handleException(dynamic error) {
    if (error is DioException) {
      final apiException = error.error;

      if (apiException is NetworkException) {
        return NetworkFailure(
          message: apiException.message,
          code: apiException.code,
        );
      }

      if (apiException is ServerException) {
        return ServerFailure(
          message: apiException.message,
          code: apiException.code,
        );
      }

      if (apiException is UnauthorizedException) {
        return UnauthorizedFailure(
          message: apiException.message,
          code: apiException.code,
        );
      }

      if (apiException is NotFoundException) {
        return NotFoundFailure(
          message: apiException.message,
          code: apiException.code,
        );
      }

      if (apiException is ApiException) {
        return ServerFailure(
          message: apiException.message,
          code: apiException.code,
        );
      }
    }

    if (error is CacheException) {
      return CacheFailure(
        message: error.message,
      );
    }

    return ServerFailure(
      message: error.toString(),
    );
  }
}