
import '../../domain/core/failure.dart';
import '../../domain/core/result.dart';
import '../../domain/entities/StoreRating.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/review.dart';
import '../../domain/entities/store.dart';
import '../../domain/repositories/store_repository.dart';
import '../datasources/local/store_local_datasource.dart';
import '../datasources/remote/store_remote_datasource.dart';

class StoreRepositoryImpl implements StoreRepository {
  final StoreRemoteDataSource _remoteDataSource;
  final StoreLocalDataSource _localDataSource;

  StoreRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Result<List<Store>>> getStores({int page = 1, int limit = 20}) async {
    try {
      // final stores =
      //     await _remoteDataSource.getStores(page: page, limit: limit);
      //
      // // Cache stores
      // await _localDataSource.cacheStores(stores);
      //
      // return Success(stores.map((model) => model.toEntity()).toList());
      return Success(Store.dummyList(count: 3));
    } catch (e) {
      // Try to get from cache
      try {
        final cachedStores = await _localDataSource.getCachedStores();
        if (cachedStores.isNotEmpty) {
          return Success(
              cachedStores.map((model) => model.toEntity()).toList());
        }
      } catch (cacheError) {
        // Cache failed
      }

      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<Store>> getStoreById(String storeId) async {
    try {
      // final store = await _remoteDataSource.getStoreById(storeId);
      //
      // // Cache store
      // await _localDataSource.cacheStore(store);
      //
      // return Success(store.toEntity());
      return Success(Store.dummy());

    } catch (e) {
      // Try to get from cache
      try {
        final cachedStore = await _localDataSource.getCachedStoreById(storeId);
        if (cachedStore != null) {
          return Success(cachedStore.toEntity());
        }
      } catch (cacheError) {
        // Cache failed
      }

      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<List<Store>>> getTopStores({int limit = 10}) async {
    try {
      // final stores = await _remoteDataSource.getTopStores(limit: limit);
      // return Success(stores.map((model) => model.toEntity()).toList());
      return Success(Store.dummyList(count: 3));
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<List<Product>>> getStoreProducts({
    required String storeId,
    String? categoryId,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final products = await _remoteDataSource.getStoreProducts(
        storeId: storeId,
        categoryId: categoryId,
        page: page,
        limit: limit,
      );

      return Success(products.map((model) => model.toEntity()).toList());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<List<Product>>> getStoreFeaturedProducts({
    required String storeId,
    int limit = 10,
  }) async {
    try {
      final products = await _remoteDataSource.getStoreFeaturedProducts(
        storeId: storeId,
        limit: limit,
      );

      return Success(products.map((model) => model.toEntity()).toList());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<List<Store>>> searchStores({
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final stores = await _remoteDataSource.searchStores(
        query: query,
        page: page,
        limit: limit,
      );

      return Success(stores.map((model) => model.toEntity()).toList());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<void>> toggleFavoriteStore(String storeId) async {
    try {
      await _remoteDataSource.toggleFavoriteStore(storeId);

      // Update local favorite status
      final isFavorite = await _localDataSource.isFavoriteStore(storeId);
      if (isFavorite) {
        await _localDataSource.removeFavoriteStore(storeId);
      } else {
        await _localDataSource.addFavoriteStore(storeId);
      }

      return const Success(null);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<List<Store>>> getFavoriteStores() async {
    try {
      final stores = await _remoteDataSource.getFavoriteStores();
      return Success(stores.map((model) => model.toEntity()).toList());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<bool>> isFavorite(String storeId) async {
    try {
      final isFavorite = await _localDataSource.isFavoriteStore(storeId);
      return Success(isFavorite);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<List<Review>>> getStoreReviews({
    required String storeId,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final reviews = await _remoteDataSource.getStoreReviews(
        storeId: storeId,
        page: page,
        limit: limit,
      );

      return Success(reviews.map((model) => model.toEntity()).toList());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<StoreRating>> getStoreRating(String storeId) async {
    try {
      final rating = await _remoteDataSource.getStoreRating(storeId);
      return Success(rating.toEntity());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<Review>> addStoreReview({
    required String storeId,
    required double rating,
    String? comment,
  }) async {
    try {
      final review = await _remoteDataSource.addStoreReview(
        storeId: storeId,
        rating: rating,
        comment: comment,
      );

      return Success(review.toEntity());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  Failure _mapExceptionToFailure(Object e) {
    final message = e.toString();

    if (message.contains('No internet connection') ||
        message.contains('Connection timeout')) {
      return const NetworkFailure();
    } else if (message.contains('Unauthorized')) {
      return const UnauthorizedFailure();
    } else if (message.contains('Not found')) {
      return const NotFoundFailure();
    } else if (message.contains('Server error')) {
      return ServerFailure(message: message);
    } else {
      return ServerFailure(message: message);
    }
  }
}
