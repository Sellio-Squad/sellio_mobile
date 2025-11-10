import 'package:dio/dio.dart';

import '../../models/product_model.dart';
import 'api_service/api_service.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({int page = 1, int limit = 20});

  Future<List<ProductModel>> getProductsByCategory({
    required String categoryId,
    int page = 1,
    int limit = 20,
  });

  Future<ProductModel> getProductById(String productId);

  Future<List<ProductModel>> searchProducts({
    required String query,
    String? categoryId,
    double? minPrice,
    double? maxPrice,
    int page = 1,
    int limit = 20,
  });

  Future<List<ProductModel>> getFeaturedProducts(
      {int page = 1, int limit = 20});

  Future<List<ProductModel>> getTrendingProducts(
      {int page = 1, int limit = 20});

  Future<void> toggleFavoriteProduct(String productId);

  Future<List<ProductModel>> getFavoriteProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiService _apiService;

  ProductRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<ProductModel>> getProducts({int page = 1, int limit = 20}) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/products',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      final data = response.data!['data'] as List<dynamic>;
      return data
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory({
    required String categoryId,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/products/category/$categoryId',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      final data = response.data!['data'] as List<dynamic>;
      return data
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<ProductModel> getProductById(String productId) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/products/$productId',
      );

      return ProductModel.fromJson(
          response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<ProductModel>> searchProducts({
    required String query,
    String? categoryId,
    double? minPrice,
    double? maxPrice,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/products/search',
        queryParameters: {
          'query': query,
          if (categoryId != null) 'categoryId': categoryId,
          if (minPrice != null) 'minPrice': minPrice,
          if (maxPrice != null) 'maxPrice': maxPrice,
          'page': page,
          'limit': limit,
        },
      );

      final data = response.data!['data'] as List<dynamic>;
      return data
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<ProductModel>> getFeaturedProducts(
      {int page = 1, int limit = 20}) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/products/featured',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      final data = response.data!['data'] as List<dynamic>;
      return data
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<ProductModel>> getTrendingProducts(
      {int page = 1, int limit = 20}) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/products/trending',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      final data = response.data!['data'] as List<dynamic>;
      return data
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> toggleFavoriteProduct(String productId) async {
    try {
      await _apiService.post(
        '/products/$productId/favorite',
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<ProductModel>> getFavoriteProducts() async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/products/favorites',
      );

      final data = response.data!['data'] as List<dynamic>;
      return data
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final message =
          e.response!.data['message'] as String? ?? 'Unknown error occurred';

      switch (statusCode) {
        case 400:
          return Exception('Bad request: $message');
        case 401:
          return Exception('Unauthorized: $message');
        case 404:
          return Exception('Not found: $message');
        case 500:
          return Exception('Server error: $message');
        default:
          return Exception('Error: $message');
      }
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return Exception('Connection timeout');
    } else if (e.type == DioExceptionType.connectionError) {
      return Exception('No internet connection');
    } else {
      return Exception('Unknown error occurred');
    }
  }
}
