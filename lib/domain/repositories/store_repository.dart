import '../core/result.dart';
import '../entities/StoreRating.dart';
import '../entities/product.dart';
import '../entities/review.dart';
import '../entities/store.dart';

abstract class StoreRepository {
  /// Get all stores
  Future<Result<List<Store>>> getStores({
    int page = 1,
    int limit = 20,
  });

  /// Get store details by ID
  Future<Result<Store>> getStoreById(String storeId);

  /// Get top/featured stores
  Future<Result<List<Store>>> getTopStores({
    int limit = 10,
  });

  /// Get store products
  Future<Result<List<Product>>> getStoreProducts({
    required String storeId,
    String? categoryId,
    int page = 1,
    int limit = 20,
  });

  /// Get store featured products
  Future<Result<List<Product>>> getStoreFeaturedProducts({
    required String storeId,
    int limit = 10,
  });

  /// Search stores
  Future<Result<List<Store>>> searchStores({
    required String query,
    int page = 1,
    int limit = 20,
  });

  /// Toggle favorite store
  Future<Result<void>> toggleFavoriteStore(String storeId);

  /// Get favorite stores
  Future<Result<List<Store>>> getFavoriteStores();

  /// Check if store is favorite
  Future<Result<bool>> isFavorite(String storeId);

  /// Get store reviews
  Future<Result<List<Review>>> getStoreReviews({
    required String storeId,
    int page = 1,
    int limit = 20,
  });

  /// Get store rating
  Future<Result<StoreRating>> getStoreRating(String storeId);

  /// Add store review
  Future<Result<Review>> addStoreReview({
    required String storeId,
    required double rating,
    String? comment,
  });
}