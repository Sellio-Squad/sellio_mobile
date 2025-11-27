import '../../core/error/result.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../core/utils/repository_call_handler.dart';
import '../datasource/remote/favorites_remote_datasource.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource _remoteDataSource;

  FavoritesRepositoryImpl({
    required FavoritesRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Result<List<String>>> getFavoriteProductIds() async {
    return RepositoryCallHandler.call<List<String>>(
      () => _remoteDataSource.getFavoriteProductIds(),
    );
  }

  @override
  Future<Result<List<String>>> getFavoriteStoreIds() async {
    return RepositoryCallHandler.call<List<String>>(
      () => _remoteDataSource.getFavoriteStoreIds(),
    );
  }

  @override
  Future<void> toggleProductFavorite(String productId) async {
    await _remoteDataSource.toggleProductFavorite(productId: productId);
  }

  @override
  Future<void> toggleStoreFavorite(String storeId) async {
    await _remoteDataSource.toggleStoreFavorite(storeId: storeId);
  }

  @override
  Future<Result<bool>> isProductFavorite(String productId) async {
    return RepositoryCallHandler.call<bool>(
      () async {
        final favoriteIds = await _remoteDataSource.getFavoriteProductIds();
        return favoriteIds.contains(productId);
      },
    );
  }

  @override
  Future<Result<bool>> isStoreFavorite(String storeId) async {
    return RepositoryCallHandler.call<bool>(
      () async {
        final favoriteIds = await _remoteDataSource.getFavoriteStoreIds();
        return favoriteIds.contains(storeId);
      },
    );
  }

  @override
  Future<void> addProductToFavorites(String productId) async {
    final favoriteIds = await _remoteDataSource.getFavoriteProductIds();
    if (!favoriteIds.contains(productId)) {
      await _remoteDataSource.toggleProductFavorite(productId: productId);
    }
  }

  @override
  Future<void> removeProductFromFavorites(String productId) async {
    final favoriteIds = await _remoteDataSource.getFavoriteProductIds();
    if (favoriteIds.contains(productId)) {
      await _remoteDataSource.toggleProductFavorite(productId: productId);
    }
  }

  @override
  Future<void> addStoreToFavorites(String storeId) async {
    final favoriteIds = await _remoteDataSource.getFavoriteStoreIds();
    if (!favoriteIds.contains(storeId)) {
      await _remoteDataSource.toggleStoreFavorite(storeId: storeId);
    }
  }

  @override
  Future<void> removeStoreFromFavorites(String storeId) async {
    final favoriteIds = await _remoteDataSource.getFavoriteStoreIds();
    if (favoriteIds.contains(storeId)) {
      await _remoteDataSource.toggleStoreFavorite(storeId: storeId);
    }
  }
}