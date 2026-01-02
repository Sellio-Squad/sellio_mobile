import 'package:dio/dio.dart';
import '../../../core/error/failure.dart';
import 'api_exception.dart';

class ExceptionHandler {
  static Failure handleException(dynamic error) {
    if (error is DioException && error.error is ApiException) {
      final apiException = error.error as ApiException;

      if (apiException is NetworkException) {
        return NetworkFailure(
          message: apiException.message,
          code: apiException.code,
        );
      }

      if (apiException is UnauthorizedException ||
          apiException is ForbiddenException) {
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

      if (apiException is BadRequestException) {
        return ValidationFailure(
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

      return ServerFailure(
        message: apiException.message,
        code: apiException.code,
      );
    }

    return ServerFailure(
      message: error.toString(),
    );
  }
}
