import '../../core/api/api_endpoints.dart';
import '../../core/api/http_client.dart';

abstract class FavoritesRemoteDataSource {
  Future<List<String>> getFavoriteProductIds(String userId);

  Future<List<String>> getFavoriteStoreIds(String userId);

  Future<String> toggleProductFavorite({
    required String userId,
    required String productId,
  });

  Future<String> toggleStoreFavorite({
    required String userId,
    required String storeId,
  });
}

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  final HttpClient _httpClient;

  FavoritesRemoteDataSourceImpl(this._httpClient);

  @override
  Future<List<String>> getFavoriteProductIds(String userId) async {
    final response =
        await _httpClient.get(ApiEndpoints.favoriteProducts(userId));

    final favorites = response.data as List;
    return favorites.map((item) => item['productId'] as String).toList();
  }

  @override
  Future<List<String>> getFavoriteStoreIds(String userId) async {
    final response = await _httpClient.get(ApiEndpoints.favoriteStores(userId));

    if (response.data is Map && response.data.containsKey('data')) {
      final favorites = response.data['data'] as List;
      return favorites.map((item) => item['storeId'] as String).toList();
    }

    return [];
  }

  @override
  Future<String> toggleProductFavorite({
    required String userId,
    required String productId,
  }) async {
    final response = await _httpClient.post(
      ApiEndpoints.favoriteProductsToggle,
      data: {
        'userId': userId,
        'productId': productId,
      },
    );

    return response.data as String;
  }

  @override
  Future<String> toggleStoreFavorite({
    required String userId,
    required String storeId,
  }) async {
    final response = await _httpClient.post(
      ApiEndpoints.favoriteStoresToggle,
      data: {
        'userId': userId,
        'storeId': storeId,
      },
    );

    return response.data as String;
  }
}
