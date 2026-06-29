import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../storage/core_storage_keys.dart';
import '../../storage/storage_service.dart';

class AuthInterceptor extends Interceptor {
  final StorageService _storageService;
  final Dio _dio;
  final String _refreshTokenPath;

  AuthInterceptor({
    required StorageService storageService,
    required Dio dio,
    required String refreshTokenPath,
  })  : _storageService = storageService,
        _dio = dio,
        _refreshTokenPath = refreshTokenPath;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await _storageService.get<String>(CoreStorageKeys.authToken);
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }

      handler.next(options);
    } catch (e) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: 'Failed to attach auth token: ${e.toString()}',
          type: DioExceptionType.unknown,
        ),
      );
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final refreshed = await _refreshToken();
        if (refreshed) {
          final response = await _retry(err.requestOptions);

          return handler.resolve(response);
        } else {
          await _clearAuthData();
        }
      } catch (e) {
        await _clearAuthData();
      }
    }

    handler.next(err);
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken =
          await _storageService.get<String>(CoreStorageKeys.refreshToken);

      if (refreshToken == null || refreshToken.isEmpty) {
        return false;
      }

      final response = await _dio.post(
        _refreshTokenPath,
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['accessToken'] as String;
        final newRefreshToken = response.data['refreshToken'] as String?;
        debugPrint("newAccessToken newAccessToken");

        await _storageService.save<String>(
            CoreStorageKeys.authToken, newAccessToken);
        if (newRefreshToken != null) {
          await _storageService.save<String>(
              CoreStorageKeys.refreshToken, newRefreshToken);
        }

        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> _clearAuthData() async {
    await _storageService.remove(CoreStorageKeys.authToken);
    await _storageService.remove(CoreStorageKeys.refreshToken);
    await _storageService.remove(CoreStorageKeys.isLoggedIn);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final token = await _storageService.get<String>(CoreStorageKeys.authToken);

    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $token',
      },
    );

    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
