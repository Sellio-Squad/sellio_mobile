import 'package:core/error/result.dart';
import '../entities/product.dart';
import '../entities/store.dart';

abstract class FavoritesRepository {
  Future<void> toggleProductFavorite(String productId);

  Future<void> toggleStoreFavorite(String storeId);
  Future<Result<List<Product>>> getFavoriteProductsFull();

  Future<Result<List<Store>>> getFavoriteStoresFull();
}
