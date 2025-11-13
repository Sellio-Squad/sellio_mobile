import '../../domain/core/result.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../core/utils/repository_call_handler.dart';
import '../core/storage/secure_storage.dart';
import '../datasources/local/favorites_local_datasource.dart';
import '../datasources/remote/favorites_remote_datasource.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource _remoteDataSource;
  final FavoritesLocalDataSource _localDataSource;
  final SecureStorage _secureStorage;

  FavoritesRepositoryImpl({
    required FavoritesRemoteDataSource remoteDataSource,
    required FavoritesLocalDataSource localDataSource,
    required SecureStorage secureStorage,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _secureStorage = secureStorage;

  @override
  Future<Result<List<String>>> getFavoriteProductIds() async {
    return RepositoryCallHandler.call<List<String>>(() async {
      // Try local first
      final localIds = await _localDataSource.getFavoriteProductIds();
      if (localIds.isNotEmpty) {
        // Sync in background
        _syncFavoriteProducts();
        return localIds;
      }

      // Fetch from server
      final userId = await _secureStorage.getUserId();
      if (userId == null) return [];

      try {
        final remoteIds = await _remoteDataSource.getFavoriteProductIds(userId);
        await _localDataSource.saveFavoriteProductIds(remoteIds);
        return remoteIds;
      } catch (e) {
        // Return local data on error
        return await _localDataSource.getFavoriteProductIds();
      }
    });
  }

  @override
  Future<Result<List<String>>> getFavoriteStoreIds() async {
    return RepositoryCallHandler.call<List<String>>(() async {
      final localIds = await _localDataSource.getFavoriteStoreIds();
      if (localIds.isNotEmpty) {
        _syncFavoriteStores();
        return localIds;
      }

      final userId = await _secureStorage.getUserId();
      if (userId == null) return [];

      try {
        final remoteIds = await _remoteDataSource.getFavoriteStoreIds(userId);
        await _localDataSource.saveFavoriteStoreIds(remoteIds);
        return remoteIds;
      } catch (e) {
        return await _localDataSource.getFavoriteStoreIds();
      }
    });
  }

  Future<void> _syncFavoriteProducts() async {
    try {
      final userId = await _secureStorage.getUserId();
      if (userId == null) return;

      final remoteIds = await _remoteDataSource.getFavoriteProductIds(userId);
      await _localDataSource.saveFavoriteProductIds(remoteIds);
    } catch (e) {
      // Silent fail for background sync
    }
  }

  Future<void> _syncFavoriteStores() async {
    try {
      final userId = await _secureStorage.getUserId();
      if (userId == null) return;

      final remoteIds = await _remoteDataSource.getFavoriteStoreIds(userId);
      await _localDataSource.saveFavoriteStoreIds(remoteIds);
    } catch (e) {
      // Silent fail for background sync
    }
  }

  @override
  Future<Result<void>> toggleProductFavorite(String productId) async {
    return RepositoryCallHandler.callVoid(() async {
      // Update local first for instant feedback
      await _localDataSource.toggleProductFavorite(productId);

      try {
        // Sync with server
        final userId = await _secureStorage.getUserId();
        if (userId != null) {
          await _remoteDataSource.toggleProductFavorite(
            userId: userId,
            productId: productId,
          );
        }
      } catch (e) {
        // Revert local change on error
        await _localDataSource.toggleProductFavorite(productId);
        rethrow;
      }
    });
  }

  @override
  Future<Result<void>> toggleStoreFavorite(String storeId) async {
    return RepositoryCallHandler.callVoid(() async {
      await _localDataSource.toggleStoreFavorite(storeId);

      try {
        final userId = await _secureStorage.getUserId();
        if (userId != null) {
          await _remoteDataSource.toggleStoreFavorite(
            userId: userId,
            storeId: storeId,
          );
        }
      } catch (e) {
        await _localDataSource.toggleStoreFavorite(storeId);
        rethrow;
      }
    });
  }

  @override
  Future<Result<bool>> isProductFavorite(String productId) async {
    return RepositoryCallHandler.call<bool>(
      () => _localDataSource.isProductFavorite(productId),
    );
  }

  @override
  Future<Result<bool>> isStoreFavorite(String storeId) async {
    return RepositoryCallHandler.call<bool>(
      () => _localDataSource.isStoreFavorite(storeId),
    );
  }

  @override
  Future<Result<void>> addProductToFavorites(String productId) async {
    return RepositoryCallHandler.callVoid(() async {
      final isFavoriteResult = await isProductFavorite(productId);
      if (isFavoriteResult is Success<bool> && !isFavoriteResult.data) {
        final toggleResult = await toggleProductFavorite(productId);
        if (toggleResult is ResultFailure) {
          throw Exception('Failed to add product to favorites');
        }
      }
    });
  }

  @override
  Future<Result<void>> removeProductFromFavorites(String productId) async {
    return RepositoryCallHandler.callVoid(() async {
      final isFavoriteResult = await isProductFavorite(productId);
      if (isFavoriteResult is Success<bool> && isFavoriteResult.data) {
        final toggleResult = await toggleProductFavorite(productId);
        if (toggleResult is ResultFailure) {
          throw Exception('Failed to remove product from favorites');
        }
      }
    });
  }

  @override
  Future<Result<void>> addStoreToFavorites(String storeId) async {
    return RepositoryCallHandler.callVoid(() async {
      final isFavoriteResult = await isStoreFavorite(storeId);
      if (isFavoriteResult is Success<bool> && !isFavoriteResult.data) {
        final toggleResult = await toggleStoreFavorite(storeId);
        if (toggleResult is ResultFailure) {
          throw Exception('Failed to add store to favorites');
        }
      }
    });
  }

  @override
  Future<Result<void>> removeStoreFromFavorites(String storeId) async {
    return RepositoryCallHandler.callVoid(() async {
      final isFavoriteResult = await isStoreFavorite(storeId);
      if (isFavoriteResult is Success<bool> && isFavoriteResult.data) {
        final toggleResult = await toggleStoreFavorite(storeId);
        if (toggleResult is ResultFailure) {
          throw Exception('Failed to remove store from favorites');
        }
      }
    });
  }
}
