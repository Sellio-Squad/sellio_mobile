import '../../core/error/result.dart';
import '../../domain/entities/StoreRating.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/review.dart';
import '../../domain/entities/store.dart';
import '../../domain/repositories/store_repository.dart';
import '../core/storage/auth/auth_storage.dart';
import '../core/utils/repository_call_handler.dart';
import '../datasources/remote/favorites_remote_datasource.dart';
import '../datasources/remote/store_remote_datasource.dart';

class StoreRepositoryImpl implements StoreRepository {
  final StoreRemoteDataSource _remoteDataSource;
  final FavoritesRemoteDataSource _favoritesRemoteDataSource;
  final AuthStorage _authStorage;

  StoreRepositoryImpl({
    required StoreRemoteDataSource remoteDataSource,
    required FavoritesRemoteDataSource favoritesRemoteDataSource,
    required AuthStorage authStorage,
  })  : _remoteDataSource = remoteDataSource,
        _favoritesRemoteDataSource = favoritesRemoteDataSource,
        _authStorage = authStorage;

  @override
  Future<Result<List<Store>>> getStores({
    int page = 1,
    int limit = 20,
  }) async {
    return RepositoryCallHandler.call<List<Store>>(() async {
      final paginatedResponse = await _remoteDataSource.getStores(
        page: page - 1,
        pageSize: limit,
      );

      return paginatedResponse.data.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Result<Store>> getStoreById(String storeId) async {
    return RepositoryCallHandler.call<Store>(() async {
      final storeModel = await _remoteDataSource.getStoreById(storeId);
      return storeModel.toEntity();
    });
  }

  @override
  Future<Result<List<Store>>> getTopStores({
    int limit = 10,
  }) async {
    return RepositoryCallHandler.call<List<Store>>(() async {
      final paginatedResponse = await _remoteDataSource.getTopStores(
        pageSize: limit,
      );

      return paginatedResponse.data.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Result<List<Product>>> getStoreProducts({
    required String storeId,
    String? categoryId,
    int page = 1,
    int limit = 20,
  }) async {
    return RepositoryCallHandler.call<List<Product>>(() async {
      final paginatedResponse = await _remoteDataSource.getStoreProducts(
        storeId: storeId,
        categoryId: categoryId,
        page: page - 1,
        pageSize: limit,
      );

      return paginatedResponse.data.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Result<List<Product>>> getStoreFeaturedProducts({
    required String storeId,
    int limit = 10,
  }) async {
    return RepositoryCallHandler.call<List<Product>>(() async {
      final paginatedResponse = await _remoteDataSource.getStoreProducts(
        storeId: storeId,
        page: 0,
        pageSize: limit * 2,
      );

      return paginatedResponse.data
          .map((model) => model.toEntity())
          .where((product) => product.isAvailable)
          .take(limit)
          .toList();
    });
  }

  @override
  Future<Result<List<Store>>> searchStores({
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    return RepositoryCallHandler.call<List<Store>>(() async {
      final paginatedResponse = await _remoteDataSource.searchStores(
        query: query,
        page: page - 1,
        pageSize: limit,
      );

      return paginatedResponse.data.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Result<void>> toggleFavoriteStore(String storeId) async {
    return RepositoryCallHandler.callWithAuth<void>(
          () => _authStorage.getUserId(),
          (userId) => _favoritesRemoteDataSource.toggleStoreFavorite(
        userId: userId,
        storeId: storeId,
      ),
    );
  }

  @override
  Future<Result<List<Store>>> getFavoriteStores() async {
    return RepositoryCallHandler.callWithAuth<List<Store>>(
          () => _authStorage.getUserId(),
          (userId) async {
        final storeIds = await _favoritesRemoteDataSource.getFavoriteStoreIds(userId);

        final stores = <Store>[];
        for (final storeId in storeIds) {
          try {
            final storeModel = await _remoteDataSource.getStoreById(storeId);
            stores.add(storeModel.toEntity());
          } catch (e) {
            continue;
          }
        }

        return stores;
      },
    );
  }

  @override
  Future<Result<bool>> isFavorite(String storeId) async {
    return RepositoryCallHandler.callWithAuth<bool>(
          () => _authStorage.getUserId(),
          (userId) async {
        final favoriteIds = await _favoritesRemoteDataSource.getFavoriteStoreIds(userId);
        return favoriteIds.contains(storeId);
      },
    );
  }

  @override
  Future<Result<List<Review>>> getStoreReviews({
    required String storeId,
    int page = 1,
    int limit = 20,
  }) async {
    return RepositoryCallHandler.call<List<Review>>(() async {
      final paginatedResponse = await _remoteDataSource.getStoreReviews(
        storeId: storeId,
        page: page - 1,
        pageSize: limit,
      );

      return paginatedResponse.data.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Result<StoreRating>> getStoreRating(String storeId) async {
    return RepositoryCallHandler.call<StoreRating>(() async {
      final ratingModel = await _remoteDataSource.getStoreRating(storeId);
      return ratingModel.toEntity();
    });
  }

  @override
  Future<Result<Review>> addStoreReview({
    required String storeId,
    required double rating,
    String? comment,
  }) async {
    return RepositoryCallHandler.call<Review>(() async {
      final reviewModel = await _remoteDataSource.addStoreReview(
        storeId: storeId,
        rating: rating,
        comment: comment,
      );

      return reviewModel.toEntity();
    });
  }
}