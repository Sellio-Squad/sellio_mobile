import '../../core/api/api_client.dart';
import '../../core/api/api_endpoints.dart';
import '../../mappers/favorite_mapper.dart';
import '../../models/common/paginated_response.dart';
import '../../models/product_model.dart';
import '../../models/request/favorite_product_request.dart';
import '../../models/request/favorite_store_request.dart';
import '../../models/store_model.dart';

abstract class FavoritesRemoteDataSource {
  Future<List<String>> getFavoriteProductIds();

  Future<List<String>> getFavoriteStoreIds();

  Future<void> toggleProductFavorite({required String productId});

  Future<void> toggleStoreFavorite({required String storeId});

  Future<PaginatedResponse<ProductModel>> getFavoriteProductsFull();

  Future<PaginatedResponse<StoreModel>> getFavoriteStoresFull();
}

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  final ApiClient _httpClient;

  FavoritesRemoteDataSourceImpl(this._httpClient);

  @override
  Future<List<String>> getFavoriteProductIds() async {
    final response = await _httpClient.get(ApiEndpoints.favoriteProducts);
    return FavoriteMapper.toProductIdListFromJson(response.data);
  }

  @override
  Future<List<String>> getFavoriteStoreIds() async {
    final response = await _httpClient.get(ApiEndpoints.favoriteStores);
    return FavoriteMapper.toStoreIdListFromJson(response.data);
  }

  @override
  Future<void> toggleProductFavorite({required String productId}) async {
    final request = FavoriteProductToggleRequest(productId: productId);
    await _httpClient.post(
      ApiEndpoints.favoriteProductToggle(productId),
      data: request.toJson(),
    );
  }

  @override
  Future<void> toggleStoreFavorite({required String storeId}) async {
    final request = FavoriteStoreToggleRequest(storeId: storeId);
    await _httpClient.post(
      ApiEndpoints.favoriteStoreToggle(storeId),
      data: request.toJson(),
    );
  }

  @override
  Future<PaginatedResponse<ProductModel>> getFavoriteProductsFull() async {
    final response = await _httpClient.get(ApiEndpoints.favoriteProducts);
    return PaginatedResponse.fromJson(
      response.data,
      (json) => ProductModel.fromJson(json),
    );
  }

  @override
  Future<PaginatedResponse<StoreModel>> getFavoriteStoresFull() async {
    final response = await _httpClient.get(ApiEndpoints.favoriteStores);
    return PaginatedResponse.fromJson(
      response.data,
      (json) => StoreModel.fromJson(json),
    );
  }
}
