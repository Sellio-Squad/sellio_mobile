import 'package:dio/dio.dart';
import 'package:sellio_mobile/data/core/api/api_endpoints.dart';
import '../storage/storage_keys.dart';
import '../storage/storage_service.dart';

class AuthInterceptor extends Interceptor {
  final StorageService _storageService;
  final Dio _dio;

  AuthInterceptor({
    required StorageService storageService,
    required Dio dio,
  })  : _storageService = storageService,
        _dio = dio;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await _storageService.get<String>(StorageKeys.authToken);

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
          await _storageService.get<String>(StorageKeys.refreshToken);

      if (refreshToken == null || refreshToken.isEmpty) {
        return false;
      }

      final response = await _dio.post(
        ApiEndpoints.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final newAccessToken = response.data['accessToken'] as String;
        final newRefreshToken = response.data['refreshToken'] as String?;

        await _storageService.save<String>(
            StorageKeys.authToken, newAccessToken);
        if (newRefreshToken != null) {
          await _storageService.save<String>(
              StorageKeys.refreshToken, newRefreshToken);
        }

        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> _clearAuthData() async {
    await _storageService.remove(StorageKeys.authToken);
    await _storageService.remove(StorageKeys.refreshToken);
    await _storageService.remove(StorageKeys.userId);
    await _storageService.remove(StorageKeys.isLoggedIn);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final token = await _storageService.get<String>(StorageKeys.authToken);

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
