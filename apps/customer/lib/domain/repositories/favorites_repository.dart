import '../../core/error/result.dart';
import '../entities/product.dart';
import '../entities/store.dart';

abstract class FavoritesRepository {
  Future<Result<List<String>>> getFavoriteProductIds();

  Future<Result<List<String>>> getFavoriteStoreIds();

  Future<void> toggleProductFavorite(String productId);

  Future<void> toggleStoreFavorite(String storeId);

  Future<Result<bool>> isProductFavorite(String productId);

  Future<Result<bool>> isStoreFavorite(String storeId);

  Future<void> addProductToFavorites(String productId);

  Future<void> removeProductFromFavorites(String productId);

  Future<void> addStoreToFavorites(String storeId);

  Future<void> removeStoreFromFavorites(String storeId);

  Future<Result<List<Product>>> getFavoriteProductsFull();

  Future<Result<List<Store>>> getFavoriteStoresFull();
}
