abstract class FavoritesRepository {
  /// Get all favorite product IDs
  Future<List<String>> getFavoriteProductIds();

  /// Get all favorite store IDs
  Future<List<String>> getFavoriteStoreIds();

  /// Toggle product favorite status
  Future<void> toggleProductFavorite(String productId);

  /// Toggle store favorite status
  Future<void> toggleStoreFavorite(String storeId);

  /// Check if product is favorite
  Future<bool> isProductFavorite(String productId);

  /// Check if store is favorite
  Future<bool> isStoreFavorite(String storeId);

  /// Add product to favorites
  Future<void> addProductToFavorites(String productId);

  /// Remove product from favorites
  Future<void> removeProductFromFavorites(String productId);

  /// Add store to favorites
  Future<void> addStoreToFavorites(String storeId);

  /// Remove store from favorites
  Future<void> removeStoreFromFavorites(String storeId);
}