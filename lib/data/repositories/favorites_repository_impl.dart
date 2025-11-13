import '../../core/error/result.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../core/storage/auth/auth_storage.dart';
import '../core/utils/repository_call_handler.dart';
import '../datasources/remote/favorites_remote_datasource.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource _remoteDataSource;
  final AuthStorage _authStorage;

  FavoritesRepositoryImpl({
    required FavoritesRemoteDataSource remoteDataSource,
    required AuthStorage authStorage,
  })  : _remoteDataSource = remoteDataSource,
        _authStorage = authStorage;

  @override
  Future<Result<List<String>>> getFavoriteProductIds() async {
    return RepositoryCallHandler.callWithAuth<List<String>>(
          () => _authStorage.getUserId(),
          (userId) => _remoteDataSource.getFavoriteProductIds(userId),
    );
  }

  @override
  Future<Result<List<String>>> getFavoriteStoreIds() async {
    return RepositoryCallHandler.callWithAuth<List<String>>(
          () => _authStorage.getUserId(),
          (userId) => _remoteDataSource.getFavoriteStoreIds(userId),
    );
  }

  @override
  Future<Result<void>> toggleProductFavorite(String productId) async {
    return RepositoryCallHandler.callWithAuth<void>(
          () => _authStorage.getUserId(),
          (userId) => _remoteDataSource.toggleProductFavorite(
        userId: userId,
        productId: productId,
      ),
    );
  }

  @override
  Future<Result<void>> toggleStoreFavorite(String storeId) async {
    return RepositoryCallHandler.callWithAuth<void>(
          () => _authStorage.getUserId(),
          (userId) => _remoteDataSource.toggleStoreFavorite(
        userId: userId,
        storeId: storeId,
      ),
    );
  }

  @override
  Future<Result<bool>> isProductFavorite(String productId) async {
    return RepositoryCallHandler.callWithAuth<bool>(
          () => _authStorage.getUserId(),
          (userId) async {
        final favoriteIds = await _remoteDataSource.getFavoriteProductIds(userId);
        return favoriteIds.contains(productId);
      },
    );
  }

  @override
  Future<Result<bool>> isStoreFavorite(String storeId) async {
    return RepositoryCallHandler.callWithAuth<bool>(
          () => _authStorage.getUserId(),
          (userId) async {
        final favoriteIds = await _remoteDataSource.getFavoriteStoreIds(userId);
        return favoriteIds.contains(storeId);
      },
    );
  }

  @override
  Future<Result<void>> addProductToFavorites(String productId) async {
    return RepositoryCallHandler.callWithAuth<void>(
          () => _authStorage.getUserId(),
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
          () => _authStorage.getUserId(),
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
          () => _authStorage.getUserId(),
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
          () => _authStorage.getUserId(),
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