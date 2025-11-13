import '../../core/api/api_endpoints.dart';
import '../../core/api/http_client.dart';
import '../../models/base/paginated_response.dart';
import '../../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<PaginatedResponse<ProductModel>> getProducts({
    int page = 0,
    int pageSize = 20,
  });

  Future<PaginatedResponse<ProductModel>> getProductsByCategory({
    required String categoryId,
    int page = 0,
    int pageSize = 20,
  });

  Future<ProductModel> getProductById(String productId);

  Future<PaginatedResponse<ProductModel>> searchProducts({
    required String query,
    int page = 0,
    int pageSize = 20,
  });

  Future<PaginatedResponse<ProductModel>> getFeaturedProducts({
    int page = 0,
    int pageSize = 20,
  });

  Future<PaginatedResponse<ProductModel>> getTrendingProducts({
    int page = 0,
    int pageSize = 20,
  });

  Future<PaginatedResponse<ProductModel>> getUsedProducts({
    int page = 0,
    int pageSize = 20,
  });
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final HttpClient _httpClient;

  ProductRemoteDataSourceImpl(this._httpClient);

  @override
  Future<PaginatedResponse<ProductModel>> getProducts({
    int page = 0,
    int pageSize = 20,
  }) async {
    final response = await _httpClient.get(
      ApiEndpoints.products,
      queryParameters: {
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
  Future<PaginatedResponse<ProductModel>> getProductsByCategory({
    required String categoryId,
    int page = 0,
    int pageSize = 20,
  }) async {
    final response = await _httpClient.get(
      ApiEndpoints.productsByCategory(categoryId),
      queryParameters: {
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
  Future<ProductModel> getProductById(String productId) async {
    final response = await _httpClient.get(
      ApiEndpoints.productById(productId),
    );

    return ProductModel.fromJson(response.data);
  }

  @override
  Future<PaginatedResponse<ProductModel>> searchProducts({
    required String query,
    int page = 0,
    int pageSize = 20,
  }) async {
    final response = await _httpClient.get(
      ApiEndpoints.productsSearch,
      queryParameters: {
        'query': query,
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
  Future<PaginatedResponse<ProductModel>> getFeaturedProducts({
    int page = 0,
    int pageSize = 20,
  }) async {
    final response = await _httpClient.get(
      ApiEndpoints.productsFeatured,
      queryParameters: {
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
  Future<PaginatedResponse<ProductModel>> getTrendingProducts({
    int page = 0,
    int pageSize = 20,
  }) async {
    final response = await _httpClient.get(
      ApiEndpoints.productsTrending,
      queryParameters: {
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
  Future<PaginatedResponse<ProductModel>> getUsedProducts({
    int page = 0,
    int pageSize = 20,
  }) async {
    final response = await _httpClient.get(
      ApiEndpoints.productsUsed,
      queryParameters: {
        'page': page,
        'size': pageSize,
      },
    );

    return PaginatedResponse.fromJson(
      response.data,
          (json) => ProductModel.fromJson(json),
    );
  }
}