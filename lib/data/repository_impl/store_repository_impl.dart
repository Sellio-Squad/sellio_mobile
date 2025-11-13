import '../../domain/core/failure.dart';
import '../../domain/core/result.dart';
import '../../domain/entities/StoreRating.dart';
import '../../domain/entities/store.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/review.dart';
import '../../domain/repositories/store_repository.dart';
import '../datasources/remote/store_remote_datasource.dart';

class StoreRepositoryImpl implements StoreRepository {
  final StoreRemoteDataSource _remoteDataSource;

  StoreRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<Store>>> getStores({int page = 1, int limit = 20}) async {
    try {
      // final stores = await _remoteDataSource.getStores(page: page, limit: limit);
      final dummyStores = Store.dummyList(count: limit);
      return Success(dummyStores);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<Store>> getStoreById(String storeId) async {
    try {
      // final store = await _remoteDataSource.getStoreById(storeId);
      final dummyStore = Store.dummy(index: 0).copyWith(id: storeId);
      return Success(dummyStore);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<List<Store>>> getTopStores({int limit = 10}) async {
    try {
      // final stores = await _remoteDataSource.getTopStores(limit: limit);
      final topStores = Store.dummyList(count: limit);
      return Success(topStores);
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
      // final products = await _remoteDataSource.getStoreProducts(...);
      final dummyProducts = Product.dummyList(count: 5);
      return Success(dummyProducts);
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
      // final products = await _remoteDataSource.getStoreFeaturedProducts(...);
      final featuredProducts = Product.dummyList(count: limit);
      return Success(featuredProducts);
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
      // final stores = await _remoteDataSource.searchStores(...);
      final dummyResults = Store.dummyList(count: 3)
          .where((s) => s.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      return Success(dummyResults);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<void>> toggleFavoriteStore(String storeId) async {
    try {
      // await _remoteDataSource.toggleFavoriteStore(storeId);
      return const Success(null);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<List<Store>>> getFavoriteStores() async {
    try {
      // final stores = await _remoteDataSource.getFavoriteStores();
      final favorites = Store.dummyList(count: 2);
      return Success(favorites);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<bool>> isFavorite(String storeId) async {
    try {
      // final result = await _remoteDataSource.isFavorite(storeId);
      return const Success(true);
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
      // final reviews = await _remoteDataSource.getStoreReviews(...);
      final dummyReviews = Review.dummyList(count: 3);
      return Success(dummyReviews);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<StoreRating>> getStoreRating(String storeId) async {
    try {
      // final rating = await _remoteDataSource.getStoreRating(storeId);
      final dummyRating = StoreRating(
        storeId: storeId,
        averageRating: 4.5,
        totalReviews: 45,
        ratingDistribution: {
          5: 30,
          4: 10,
          3: 3,
          2: 1,
          1: 1,
        },
      );
      return Success(dummyRating);
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
      // final review = await _remoteDataSource.addStoreReview(...);
      final newReview = Review.dummy().copyWith(
        comment: comment ?? 'Great store!',
        rating: rating,
      );
      return Success(newReview);
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
