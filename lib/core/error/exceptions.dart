import 'package:equatable/equatable.dart';

abstract class AppException extends Equatable implements Exception {
  const AppException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class ServerException extends AppException {
  const ServerException({
    required super.message,
    required super.statusCode,
  });
}

class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.statusCode = 500,
  });
}

class NetworkException extends AppException {
  const NetworkException({
    super.message = 'No internet connection',
    super.statusCode = 503,
  });
}

class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Unauthorized',
    super.statusCode = 401,
  });
}