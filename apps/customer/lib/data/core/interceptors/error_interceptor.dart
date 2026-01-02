import 'package:dio/dio.dart';
import '../exceptions/api_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = _mapError(err);

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: exception
      ),
    );
  }

  ApiException _mapError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          message: 'Connection timeout',
          statusCode: 408,
        );

      case DioExceptionType.connectionError:
        return NetworkException(
          message: 'No internet connection',
          statusCode: 0,
        );

      case DioExceptionType.badResponse:
        return _mapResponseError(error.response);

      case DioExceptionType.cancel:
        return UnknownApiException(
          message: 'Request cancelled',
          statusCode: 0,
        );

      case DioExceptionType.unknown:
      default:
        return UnknownApiException(
          message: 'Unexpected error occurred',
          statusCode: 0,
        );
    }
  }

  ApiException _mapResponseError(Response? response) {
    final statusCode = response?.statusCode ?? 0;
    final data = response?.data;

    String message = 'An error occurred';
    String? code;

    if (data is Map<String, dynamic>) {
      message = data['message'] ?? message;
      code = data['code'];
    }

    switch (statusCode) {
      case 400:
        return BadRequestException(
          message: message,
          statusCode: statusCode,
          code: code,
          data: data,
        );
      case 401:
        return UnauthorizedException(
          message: message,
          statusCode: statusCode,
          code: code,
        );
      case 403:
        return ForbiddenException(
          message: message,
          statusCode: statusCode,
          code: code,
        );
      case 404:
        return NotFoundException(
          message: message,
          statusCode: statusCode,
          code: code,
        );
      case 409:
        return ConflictException(
          message: message,
          statusCode: statusCode,
          code: code,
        );
      case 500:
      case 502:
      case 503:
        return ServerException(
          message: message,
          statusCode: statusCode,
          code: code,
          data: data,
        );
      default:
        return UnknownApiException(
          message: message,
          statusCode: statusCode,
          code: code,
          data: data,
        );
    }
  }
}
