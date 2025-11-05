import '../entities/store.dart';
import '../entities/product.dart';
import '../entities/review.dart';

abstract class StoreRepository {
  /// Get all stores
  Future<List<Store>> getStores({
    int page = 1,
    int limit = 20,
  });

  /// Get store details by ID
  Future<Store> getStoreById(String storeId);

  /// Get top/featured stores
  Future<List<Store>> getTopStores({
    int limit = 10,
  });

  /// Get store products
  Future<List<Product>> getStoreProducts({
    required String storeId,
    String? categoryId,
    int page = 1,
    int limit = 20,
  });

  /// Get store featured products
  Future<List<Product>> getStoreFeaturedProducts({
    required String storeId,
    int limit = 10,
  });

  /// Search stores
  Future<List<Store>> searchStores({
    required String query,
    int page = 1,
    int limit = 20,
  });

  /// Toggle favorite store
  Future<void> toggleFavoriteStore(String storeId);

  /// Get favorite stores
  Future<List<Store>> getFavoriteStores();

  /// Check if store is favorite
  Future<bool> isFavorite(String storeId);

  /// Get store reviews
  Future<List<Review>> getStoreReviews({
    required String storeId,
    int page = 1,
    int limit = 20,
  });

  /// Get store rating
  Future<StoreRating> getStoreRating(String storeId);

  /// Add store review
  Future<Review> addStoreReview({
    required String storeId,
    required double rating,
    String? comment,
  });
}