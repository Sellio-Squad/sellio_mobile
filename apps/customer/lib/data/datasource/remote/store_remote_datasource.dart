import 'package:sellio_mobile/data/models/store_top_rating_model.dart';

import '../../core/api/api_client.dart';
import '../../core/api/api_endpoints.dart';
import '../../models/common/paginated_response.dart';
import '../../models/product_model.dart';
import '../../models/review_model.dart';
import '../../models/store_model.dart';
import '../../models/store_rating_model.dart';

abstract class StoreRemoteDataSource {
  Future<PaginatedResponse<StoreModel>> getStores({
    int page = 0,
    int pageSize = 20,
  });

  Future<StoreModel> getStoreById(String storeId);

  Future<PaginatedResponse<StoreTopRatingModel>> getTopStores({
    int page = 0,
    int pageSize = 10,
  });

  Future<PaginatedResponse<ProductModel>> getStoreProducts({
    required String storeId,
    String? categoryId,
    int page = 0,
    int pageSize = 20,
  });

  Future<PaginatedResponse<StoreModel>> searchStores({
    required String query,
    int page = 0,
    int pageSize = 20,
  });

  Future<PaginatedResponse<ReviewModel>> getStoreReviews({
    required String storeId,
    int page = 0,
    int pageSize = 20,
  });

  Future<StoreRatingModel> getStoreRating(String storeId);

  Future<ReviewModel> addStoreReview({
    required String storeId,
    required double rating,
    String? comment,
  });

  Future<String> uploadStoreImage({
    required String storeId,
    required String filePath,
    required String imageType, // 'avatar' or 'cover'
  });
}

class StoreRemoteDataSourceImpl implements StoreRemoteDataSource {
  final ApiClient _httpClient;

  StoreRemoteDataSourceImpl(this._httpClient);

  @override
  Future<PaginatedResponse<StoreModel>> getStores({
    int page = 0,
    int pageSize = 20,
  }) async {
    final response = await _httpClient.get(
      ApiEndpoints.stores,
      queryParameters: {
        'page': page,
        'size': pageSize,
      },
    );

    return PaginatedResponse.fromJson(
      response.data,
          (json) => StoreModel.fromJson(json),
    );
  }

  @override
  Future<StoreModel> getStoreById(String storeId) async {
    final response = await _httpClient.get(ApiEndpoints.storeById(storeId));
    return StoreModel.fromJson(response.data);
  }

  @override
  Future<PaginatedResponse<StoreTopRatingModel>> getTopStores({
    int page = 0,
    int pageSize = 10,
  }) async {
    final response = await _httpClient.get(
      ApiEndpoints.storesTopRating,
      queryParameters: {
        'page': page,
        'size': pageSize,
      },
    );

    return PaginatedResponse.fromJson(
      response.data,
      (json) => StoreTopRatingModel.fromJson(json),
    );
  }

  @override
  Future<PaginatedResponse<ProductModel>> getStoreProducts({
    required String storeId,
    String? categoryId,
    int page = 0,
    int pageSize = 20,
  }) async {
    final response = await _httpClient.get(
      ApiEndpoints.productsByStore(storeId),
      queryParameters: {
        if (categoryId != null) 'categoryId': categoryId,
        'page': page,
        'size': pageSize,
      },
    );

    return PaginatedResponse.fromJson(
      response.data,
          (json) => ProductModel.fromJson(json),
    );
  }

  @override
  Future<PaginatedResponse<StoreModel>> searchStores({
    required String query,
    int page = 0,
    int pageSize = 20,
  }) async {
    final response = await _httpClient.get(
      ApiEndpoints.storesSearch,
      queryParameters: {
        'query': query,
        'page': page,
        'size': pageSize,
      },
    );

    return PaginatedResponse.fromJson(
      response.data,
          (json) => StoreModel.fromJson(json),
    );
  }

  @override
  Future<PaginatedResponse<ReviewModel>> getStoreReviews({
    required String storeId,
    int page = 0,
    int pageSize = 20,
  }) async {
    final response = await _httpClient.get(
      ApiEndpoints.storeReviewsByStore(storeId),
      queryParameters: {
        'page': page,
        'size': pageSize,
      },
    );

    return PaginatedResponse.fromJson(
      response.data,
          (json) => ReviewModel.fromJson(json),
    );
  }

  @override
  Future<StoreRatingModel> getStoreRating(String storeId) async {
    final response = await _httpClient.get(ApiEndpoints.storeRating(storeId));
    return StoreRatingModel.fromJson(response.data);
  }

  @override
  Future<ReviewModel> addStoreReview({
    required String storeId,
    required double rating,
    String? comment,
  }) async {
    final response = await _httpClient.post(
      ApiEndpoints.storeReviews,
      data: {
        'storeId': storeId,
        'rating': rating,
        'comment': comment,
      },
    );

    return ReviewModel.fromJson(response.data);
  }

  @override
  Future<String> uploadStoreImage({
    required String storeId,
    required String filePath,
    required String imageType,
  }) async {
    final response = await _httpClient.uploadFile(
      ApiEndpoints.storeImages(storeId),
      filePath,
      fieldName: 'image',
      additionalData: {'type': imageType},
    );

    return response.data['imageUrl'] as String;
  }
}
