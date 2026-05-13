import '../../core/api/api_endpoints.dart';
import '../../core/api/api_client.dart';
import '../../models/common/paginated_response.dart';
import '../../models/product_model.dart';
import '../../models/product_summary_model.dart';

abstract class ProductRemoteDataSource {
  Future<PaginatedResponse<ProductModel>> getProducts({
    int page = 0,
    int pageSize = 20,
  });

  Future<PaginatedResponse<ProductSummaryModel>> getProductsByCategory({
    required String categoryId,
    int page = 0,
    int pageSize = 20,
  });

  Future<ProductModel> getProductById(String productId);

  Future<PaginatedResponse<ProductModel>> getFeaturedProducts({
    int page = 0,
    int pageSize = 20,
  });

  Future<PaginatedResponse<ProductSummaryModel>> getTrendingProducts({
    int page = 0,
    int pageSize = 20,
  });

  Future<PaginatedResponse<ProductModel>> getThriftProducts({
    String? categoryId,
    int page = 0,
    int pageSize = 20,
  });
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient _httpClient;

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
  Future<PaginatedResponse<ProductSummaryModel>> getProductsByCategory({
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
      (json) => ProductSummaryModel.fromJson(json),
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
  Future<PaginatedResponse<ProductSummaryModel>> getTrendingProducts({
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
    print('product list: dataSource impl(1)-> $response');

    return PaginatedResponse.fromJson(
      response.data,
      (json) => ProductSummaryModel.fromJson(json),
    );
  }

  @override
  Future<PaginatedResponse<ProductModel>> getThriftProducts({
    String? categoryId,
    int page = 0,
    int pageSize = 20,
  }) async {
    final endpoint = categoryId != null
        ? ApiEndpoints.productsUsedByCategory(categoryId)
        : ApiEndpoints.productsUsed;

    final response = await _httpClient.get(
      endpoint,
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
