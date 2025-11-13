import '../../core/error/result.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../core/utils/repository_call_handler.dart';
import '../core/storage/secure_storage.dart';
import '../datasources/remote/favorites_remote_datasource.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource _remoteDataSource;
  final SecureStorage _secureStorage;

  FavoritesRepositoryImpl({
    required FavoritesRemoteDataSource remoteDataSource,
    required SecureStorage secureStorage,
  })  : _remoteDataSource = remoteDataSource,
        _secureStorage = secureStorage;

  @override
  Future<Result<List<String>>> getFavoriteProductIds() async {
    return RepositoryCallHandler.callWithAuth<List<String>>(
          () => _secureStorage.getUserId(),
          (userId) => _remoteDataSource.getFavoriteProductIds(userId),
    );
  }

  @override
  Future<Result<List<String>>> getFavoriteStoreIds() async {
    return RepositoryCallHandler.callWithAuth<List<String>>(
          () => _secureStorage.getUserId(),
          (userId) => _remoteDataSource.getFavoriteStoreIds(userId),
    );
  }

  @override
  Future<Result<void>> toggleProductFavorite(String productId) async {
    return RepositoryCallHandler.callWithAuth<void>(
          () => _secureStorage.getUserId(),
          (userId) => _remoteDataSource.toggleProductFavorite(
        userId: userId,
        productId: productId,
      ),
    );
  }

  @override
  Future<Result<void>> toggleStoreFavorite(String storeId) async {
    return RepositoryCallHandler.callWithAuth<void>(
          () => _secureStorage.getUserId(),
          (userId) => _remoteDataSource.toggleStoreFavorite(
        userId: userId,
        storeId: storeId,
      ),
    );
  }

  @override
  Future<Result<bool>> isProductFavorite(String productId) async {
    return RepositoryCallHandler.callWithAuth<bool>(
          () => _secureStorage.getUserId(),
          (userId) async {
        final favoriteIds = await _remoteDataSource.getFavoriteProductIds(userId);
        return favoriteIds.contains(productId);
      },
    );
  }

  @override
  Future<Result<bool>> isStoreFavorite(String storeId) async {
    return RepositoryCallHandler.callWithAuth<bool>(
          () => _secureStorage.getUserId(),
          (userId) async {
        final favoriteIds = await _remoteDataSource.getFavoriteStoreIds(userId);
        return favoriteIds.contains(storeId);
      },
    );
  }

  @override
  Future<Result<void>> addProductToFavorites(String productId) async {
    return RepositoryCallHandler.callWithAuth<void>(
          () => _secureStorage.getUserId(),
          (userId) async {
        final favoriteIds = await _remoteDataSource.getFavoriteProductIds(userId);
        if (!favoriteIds.contains(productId)) {
          await _remoteDataSource.toggleProductFavorite(
            userId: userId,
            productId: productId,
          );
        }
      },
    );
  }

  @override
  Future<Result<void>> removeProductFromFavorites(String productId) async {
    return RepositoryCallHandler.callWithAuth<void>(
          () => _secureStorage.getUserId(),
          (userId) async {
        final favoriteIds = await _remoteDataSource.getFavoriteProductIds(userId);
        if (favoriteIds.contains(productId)) {
          await _remoteDataSource.toggleProductFavorite(
            userId: userId,
            productId: productId,
          );
        }
      },
    );
  }

  @override
  Future<Result<void>> addStoreToFavorites(String storeId) async {
    return RepositoryCallHandler.callWithAuth<void>(
          () => _secureStorage.getUserId(),
          (userId) async {
        final favoriteIds = await _remoteDataSource.getFavoriteStoreIds(userId);
        if (!favoriteIds.contains(storeId)) {
          await _remoteDataSource.toggleStoreFavorite(
            userId: userId,
            storeId: storeId,
          );
        }
      },
    );
  }

  @override
  Future<Result<void>> removeStoreFromFavorites(String storeId) async {
    return RepositoryCallHandler.callWithAuth<void>(
          () => _secureStorage.getUserId(),
          (userId) async {
        final favoriteIds = await _remoteDataSource.getFavoriteStoreIds(userId);
        if (favoriteIds.contains(storeId)) {
          await _remoteDataSource.toggleStoreFavorite(
            userId: userId,
            storeId: storeId,
          );
        }
      },
    );
  }
}