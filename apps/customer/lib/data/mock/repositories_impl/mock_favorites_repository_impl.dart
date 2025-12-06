import '../../../core/error/result.dart';
import '../../../domain/repositories/favorites_repository.dart';

class MockFavoritesRepositoryImpl implements FavoritesRepository {
  final Set<String> _favoriteProductIds = {};
  final Set<String> _favoriteStoreIds = {};

  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<Result<List<String>>> getFavoriteProductIds() async {
    await _simulateDelay();
    return Success(_favoriteProductIds.toList());
  }

  @override
  Future<Result<List<String>>> getFavoriteStoreIds() async {
    await _simulateDelay();
    return Success(_favoriteStoreIds.toList());
  }

  @override
  Future<void> toggleProductFavorite(String productId) async {
    await _simulateDelay();

    if (_favoriteProductIds.contains(productId)) {
      _favoriteProductIds.remove(productId);
    } else {
      _favoriteProductIds.add(productId);
    }
  }

  @override
  Future<void> toggleStoreFavorite(String storeId) async {
    await _simulateDelay();

    if (_favoriteStoreIds.contains(storeId)) {
      _favoriteStoreIds.remove(storeId);
    } else {
      _favoriteStoreIds.add(storeId);
    }
  }

  @override
  Future<Result<bool>> isProductFavorite(String productId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return Success(_favoriteProductIds.contains(productId));
  }

  @override
  Future<Result<bool>> isStoreFavorite(String storeId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return Success(_favoriteStoreIds.contains(storeId));
  }

  @override
  Future<void> addProductToFavorites(String productId) async {
    await _simulateDelay();
    _favoriteProductIds.add(productId);
  }

  @override
  Future<void> removeProductFromFavorites(String productId) async {
    await _simulateDelay();
    _favoriteProductIds.remove(productId);
  }

  @override
  Future<void> addStoreToFavorites(String storeId) async {
    await _simulateDelay();
    _favoriteStoreIds.add(storeId);
  }

  @override
  Future<void> removeStoreFromFavorites(String storeId) async {
    await _simulateDelay();
    _favoriteStoreIds.remove(storeId);
  }
}
