import '../../domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  // In-memory storage for demo purposes
  final Set<String> _favoriteProductIds = {};
  final Set<String> _favoriteStoreIds = {};

  @override
  Future<List<String>> getFavoriteProductIds() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _favoriteProductIds.toList();
  }

  @override
  Future<List<String>> getFavoriteStoreIds() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _favoriteStoreIds.toList();
  }

  @override
  Future<void> toggleProductFavorite(String productId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (_favoriteProductIds.contains(productId)) {
      _favoriteProductIds.remove(productId);
    } else {
      _favoriteProductIds.add(productId);
    }
  }

  @override
  Future<void> toggleStoreFavorite(String storeId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (_favoriteStoreIds.contains(storeId)) {
      _favoriteStoreIds.remove(storeId);
    } else {
      _favoriteStoreIds.add(storeId);
    }
  }

  @override
  Future<bool> isProductFavorite(String productId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _favoriteProductIds.contains(productId);
  }

  @override
  Future<bool> isStoreFavorite(String storeId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _favoriteStoreIds.contains(storeId);
  }

  @override
  Future<void> addProductToFavorites(String productId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _favoriteProductIds.add(productId);
  }

  @override
  Future<void> removeProductFromFavorites(String productId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _favoriteProductIds.remove(productId);
  }

  @override
  Future<void> addStoreToFavorites(String storeId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _favoriteStoreIds.add(storeId);
  }

  @override
  Future<void> removeStoreFromFavorites(String storeId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _favoriteStoreIds.remove(storeId);
  }
}