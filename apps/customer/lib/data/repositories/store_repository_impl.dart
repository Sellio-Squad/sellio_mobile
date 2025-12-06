import 'package:sellio_mobile/core/error/result.dart';
import 'package:sellio_mobile/data/mappers/review_mapper.dart';
import 'package:sellio_mobile/data/mappers/store_mapper.dart';
import 'package:sellio_mobile/domain/entities/product.dart';
import 'package:sellio_mobile/domain/entities/review.dart';
import 'package:sellio_mobile/domain/entities/store.dart';
import 'package:sellio_mobile/domain/entities/store_rating.dart';
import 'package:sellio_mobile/domain/repositories/store_repository.dart';

import 'package:design_system/design_system.dart';
import '../core/storage/storage_keys.dart';
import '../core/storage/storage_service.dart';
import '../core/utils/repository_call_handler.dart';
import '../datasource/remote/favorites_remote_datasource.dart';
import '../datasource/remote/store_remote_datasource.dart';

class StoreRepositoryImpl implements StoreRepository {
  final StoreRemoteDataSource _remoteDataSource;
  final FavoritesRemoteDataSource _favoritesRemoteDataSource;
  final StorageService _storageService;

  StoreRepositoryImpl({
    required StoreRemoteDataSource remoteDataSource,
    required FavoritesRemoteDataSource favoritesRemoteDataSource,
    required StorageService storageService,
  })  : _remoteDataSource = remoteDataSource,
        _favoritesRemoteDataSource = favoritesRemoteDataSource,
        _storageService = storageService;

  Future<String?> _getUserId() =>
      _storageService.get<String>(StorageKeys.userId);

  @override
  Future<Result<List<Store>>> getStores({
    int page = RepositoryConstants.defaultPage,
    int limit = RepositoryConstants.defaultPageSize,
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
    int limit = RepositoryConstants.defaultTopStoresLimit,
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
    int page = RepositoryConstants.defaultPage,
    int limit = RepositoryConstants.defaultPageSize,
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
    int limit = RepositoryConstants.defaultFeaturedProductsLimit,
  }) async {
    return RepositoryCallHandler.call<List<Product>>(() async {
      final paginatedResponse = await _remoteDataSource.getStoreProducts(
        storeId: storeId,
        page: 0,
        pageSize: limit * RepositoryConstants.featuredProductsMultiplier,
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
    int page = RepositoryConstants.defaultPage,
    int limit = RepositoryConstants.defaultPageSize,
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
      _getUserId,
      (userId) => _favoritesRemoteDataSource.toggleStoreFavorite(
        storeId: storeId,
      ),
    );
  }

  @override
  Future<Result<List<Store>>> getFavoriteStores() async {
    return RepositoryCallHandler.callWithAuth<List<Store>>(
      _getUserId,
      (userId) async {
        final storeIds = await _favoritesRemoteDataSource.getFavoriteStoreIds();

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
      _getUserId,
      (userId) async {
        final favoriteIds =
            await _favoritesRemoteDataSource.getFavoriteStoreIds();
        return favoriteIds.contains(storeId);
      },
    );
  }

  @override
  Future<Result<List<Review>>> getStoreReviews({
    required String storeId,
    int page = RepositoryConstants.defaultPage,
    int limit = RepositoryConstants.defaultPageSize,
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
