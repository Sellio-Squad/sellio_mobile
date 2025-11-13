import '../../core/storage/local_storage.dart';

abstract class FavoritesLocalDataSource {
  Future<List<String>> getFavoriteProductIds();
  Future<List<String>> getFavoriteStoreIds();
  Future<void> saveFavoriteProductIds(List<String> productIds);
  Future<void> saveFavoriteStoreIds(List<String> storeIds);
  Future<void> toggleProductFavorite(String productId);
  Future<void> toggleStoreFavorite(String storeId);
  Future<bool> isProductFavorite(String productId);
  Future<bool> isStoreFavorite(String storeId);
  Future<void> clearAllFavorites();
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  static const _favoriteProductsKey = 'favorite_products';
  static const _favoriteStoresKey = 'favorite_stores';

  final LocalStorage _localStorage;

  FavoritesLocalDataSourceImpl(this._localStorage);

  @override
  Future<List<String>> getFavoriteProductIds() async {
    try {
      return _localStorage.getStringList(_favoriteProductsKey) ?? [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<String>> getFavoriteStoreIds() async {
    try {
      return _localStorage.getStringList(_favoriteStoresKey) ?? [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveFavoriteProductIds(List<String> productIds) async {
    await _localStorage.setStringList(_favoriteProductsKey, productIds);
  }

  @override
  Future<void> saveFavoriteStoreIds(List<String> storeIds) async {
    await _localStorage.setStringList(_favoriteStoresKey, storeIds);
  }

  @override
  Future<void> toggleProductFavorite(String productId) async {
    final favorites = await getFavoriteProductIds();

    if (favorites.contains(productId)) {
      favorites.remove(productId);
    } else {
      favorites.add(productId);
    }

    await saveFavoriteProductIds(favorites);
  }

  @override
  Future<void> toggleStoreFavorite(String storeId) async {
    final favorites = await getFavoriteStoreIds();

    if (favorites.contains(storeId)) {
      favorites.remove(storeId);
    } else {
      favorites.add(storeId);
    }

    await saveFavoriteStoreIds(favorites);
  }

  @override
  Future<bool> isProductFavorite(String productId) async {
    final favorites = await getFavoriteProductIds();
    return favorites.contains(productId);
  }

  @override
  Future<bool> isStoreFavorite(String storeId) async {
    final favorites = await getFavoriteStoreIds();
    return favorites.contains(storeId);
  }

  @override
  Future<void> clearAllFavorites() async {
    await _localStorage.remove(_favoriteProductsKey);
    await _localStorage.remove(_favoriteStoresKey);
  }
}