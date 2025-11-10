import 'package:dio/dio.dart';

import '../../models/product_model.dart';
import '../../models/review_model.dart';
import '../../models/store_model.dart';
import 'api_service/api_service.dart';

abstract class StoreRemoteDataSource {
  Future<List<StoreModel>> getStores({int page = 1, int limit = 20});

  Future<StoreModel> getStoreById(String storeId);

  Future<List<StoreModel>> getTopStores({int limit = 10});

  Future<List<ProductModel>> getStoreProducts({
    required String storeId,
    String? categoryId,
    int page = 1,
    int limit = 20,
  });

  Future<List<ProductModel>> getStoreFeaturedProducts({
    required String storeId,
    int limit = 10,
  });

  Future<List<StoreModel>> searchStores({
    required String query,
    int page = 1,
    int limit = 20,
  });

  Future<void> toggleFavoriteStore(String storeId);

  Future<List<StoreModel>> getFavoriteStores();

  Future<List<ReviewModel>> getStoreReviews({
    required String storeId,
    int page = 1,
    int limit = 20,
  });

  Future<StoreRatingModel> getStoreRating(String storeId);

  Future<ReviewModel> addStoreReview({
    required String storeId,
    required double rating,
    String? comment,
  });
}

class StoreRemoteDataSourceImpl implements StoreRemoteDataSource {
  final ApiService _apiService;

  StoreRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<StoreModel>> getStores({int page = 1, int limit = 20}) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/stores',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      final data = response.data!['data'] as List<dynamic>;
      return data
          .map((json) => StoreModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<StoreModel> getStoreById(String storeId) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/stores/$storeId',
      );

      return StoreModel.fromJson(
          response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<StoreModel>> getTopStores({int limit = 10}) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/stores/top',
        queryParameters: {
          'limit': limit,
        },
      );

      final data = response.data!['data'] as List<dynamic>;
      return data
          .map((json) => StoreModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<ProductModel>> getStoreProducts({
    required String storeId,
    String? categoryId,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/stores/$storeId/products',
        queryParameters: {
          if (categoryId != null) 'categoryId': categoryId,
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
  Future<List<ProductModel>> getStoreFeaturedProducts({
    required String storeId,
    int limit = 10,
  }) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/stores/$storeId/products/featured',
        queryParameters: {
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
  Future<List<StoreModel>> searchStores({
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/stores/search',
        queryParameters: {
          'query': query,
          'page': page,
          'limit': limit,
        },
      );

      final data = response.data!['data'] as List<dynamic>;
      return data
          .map((json) => StoreModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> toggleFavoriteStore(String storeId) async {
    try {
      await _apiService.post(
        '/stores/$storeId/favorite',
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<StoreModel>> getFavoriteStores() async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/stores/favorites',
      );

      final data = response.data!['data'] as List<dynamic>;
      return data
          .map((json) => StoreModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<ReviewModel>> getStoreReviews({
    required String storeId,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/stores/$storeId/reviews',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      final data = response.data!['data'] as List<dynamic>;
      return data
          .map((json) => ReviewModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<StoreRatingModel> getStoreRating(String storeId) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/stores/$storeId/rating',
      );

      return StoreRatingModel.fromJson(
          response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<ReviewModel> addStoreReview({
    required String storeId,
    required double rating,
    String? comment,
  }) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/stores/$storeId/reviews',
        data: {
          'rating': rating,
          if (comment != null) 'comment': comment,
        },
      );

      return ReviewModel.fromJson(
          response.data!['data'] as Map<String, dynamic>);
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
