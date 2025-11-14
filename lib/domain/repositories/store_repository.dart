import '../../core/error/result.dart';
import '../entities/store_rating.dart';
import '../entities/product.dart';
import '../entities/review.dart';
import '../entities/store.dart';

abstract class StoreRepository {
  Future<Result<List<Store>>> getStores({
    int page = 1,
    int limit = 20,
  });

  Future<Result<Store>> getStoreById(String storeId);

  Future<Result<List<Store>>> getTopStores({
    int limit = 10,
  });

  Future<Result<List<Product>>> getStoreProducts({
    required String storeId,
    String? categoryId,
    int page = 1,
    int limit = 20,
  });

  Future<Result<List<Product>>> getStoreFeaturedProducts({
    required String storeId,
    int limit = 10,
  });

  Future<Result<List<Store>>> searchStores({
    required String query,
    int page = 1,
    int limit = 20,
  });

  Future<Result<void>> toggleFavoriteStore(String storeId);

  Future<Result<List<Store>>> getFavoriteStores();

  Future<Result<bool>> isFavorite(String storeId);

  Future<Result<List<Review>>> getStoreReviews({
    required String storeId,
    int page = 1,
    int limit = 20,
  });

  Future<Result<StoreRating>> getStoreRating(String storeId);

  Future<Result<Review>> addStoreReview({
    required String storeId,
    required double rating,
    String? comment,
  });
}