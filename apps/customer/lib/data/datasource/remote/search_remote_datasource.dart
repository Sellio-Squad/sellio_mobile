import '../../core/api/api_client.dart';
import '../../core/api/api_endpoints.dart';
import '../../models/common/paginated_response.dart';
import '../../models/product_model.dart';
import '../../models/store_model.dart';

abstract class SearchRemoteDateSource {

  Future<PaginatedResponse<ProductModel>> searchProducts({
    required String query,
    int page = 0,
    int pageSize = 20,
  });

  Future<PaginatedResponse<StoreModel>> searchStores({
    required String query,
    int page = 0,
    int pageSize = 20,
  });

}

class SearchRemoteDatasourceImpl implements SearchRemoteDateSource {
  final ApiClient _httpClient;

  SearchRemoteDatasourceImpl(this._httpClient);

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

}