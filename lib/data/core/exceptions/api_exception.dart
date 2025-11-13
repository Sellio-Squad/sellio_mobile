class ApiException implements Exception {
  final String message;
  final int statusCode;
  final String? code;
  final dynamic data;

  ApiException({
    required this.message,
    required this.statusCode,
    this.code,
    this.data,
  });

  @override
  String toString() =>
      'ApiException(message: $message, code: $code, status: $statusCode)';
}

class NetworkException extends ApiException {
  NetworkException({
    required super.message,
    required super.statusCode,
    super.code,
  });
}

class ServerException extends ApiException {
  ServerException({
    required super.message,
    required super.statusCode,
    super.code,
    super.data,
  });
}

class BadRequestException extends ApiException {
  BadRequestException({
    required super.message,
    required super.statusCode,
    super.code,
    super.data,
  });
}

class UnauthorizedException extends ApiException {
  UnauthorizedException({
    required super.message,
    required super.statusCode,
    super.code,
  });
}

class ForbiddenException extends ApiException {
  ForbiddenException({
    required super.message,
    required super.statusCode,
    super.code,
  });
}

class NotFoundException extends ApiException {
  NotFoundException({
    required super.message,
    required super.statusCode,
    super.code,
  });
}

class ConflictException extends ApiException {
  ConflictException({
    required super.message,
    required super.statusCode,
    super.code,
  });
}