import 'package:flutter/cupertino.dart';
import 'package:sellio_mobile/domain/entities/product.dart';

import '../../core/error/result.dart';
import '../../domain/entities/store.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../core/utils/repository_call_handler.dart';
import '../datasource/remote/favorites_remote_datasource.dart';
import '../datasource/remote/product_remote_datasource.dart';
import '../datasource/remote/store_remote_datasource.dart';
import '../mappers/store_mapper.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource remoteDataSource;
  final ProductRemoteDataSource productRemoteDataSource;
  final StoreRemoteDataSource storeRemoteDataSource;

  FavoritesRepositoryImpl({
    required this.remoteDataSource,
    required this.productRemoteDataSource,
    required this.storeRemoteDataSource,
  });

  @override
  Future<Result<List<String>>> getFavoriteProductIds() async {
    return RepositoryCallHandler.call<List<String>>(
      () => remoteDataSource.getFavoriteProductIds(),
    );
  }

  @override
  Future<Result<List<String>>> getFavoriteStoreIds() async {
    return RepositoryCallHandler.call<List<String>>(
      () => remoteDataSource.getFavoriteStoreIds(),
    );
  }

  @override
  Future<void> toggleProductFavorite(String productId) async {
    debugPrint('toggleProductFavorite :: repo impl');
    RepositoryCallHandler.call<void>(
          () async {
            await remoteDataSource.toggleProductFavorite(productId: productId);
      },
    );
  }

  @override
  Future<void> toggleStoreFavorite(String storeId) async {
    await remoteDataSource.toggleStoreFavorite(storeId: storeId);
  }

  @override
  Future<Result<bool>> isProductFavorite(String productId) async {
    return RepositoryCallHandler.call<bool>(
      () async {
        final favoriteIds = await remoteDataSource.getFavoriteProductIds();
        return favoriteIds.contains(productId);
      },
    );
  }

  @override
  Future<Result<bool>> isStoreFavorite(String storeId) async {
    return RepositoryCallHandler.call<bool>(
      () async {
        final favoriteIds = await remoteDataSource.getFavoriteStoreIds();
        return favoriteIds.contains(storeId);
      },
    );
  }

  @override
  Future<void> addProductToFavorites(String productId) async {
    final favoriteIds = await remoteDataSource.getFavoriteProductIds();
    if (!favoriteIds.contains(productId)) {
      await remoteDataSource.toggleProductFavorite(productId: productId);
    }
  }

  @override
  Future<void> removeProductFromFavorites(String productId) async {
    final favoriteIds = await remoteDataSource.getFavoriteProductIds();
    if (favoriteIds.contains(productId)) {
      await remoteDataSource.toggleProductFavorite(productId: productId);
    }
  }

  @override
  Future<void> addStoreToFavorites(String storeId) async {
    final favoriteIds = await remoteDataSource.getFavoriteStoreIds();
    if (!favoriteIds.contains(storeId)) {
      await remoteDataSource.toggleStoreFavorite(storeId: storeId);
    }
  }

  @override
  Future<void> removeStoreFromFavorites(String storeId) async {
    final favoriteIds = await remoteDataSource.getFavoriteStoreIds();
    if (favoriteIds.contains(storeId)) {
      await remoteDataSource.toggleStoreFavorite(storeId: storeId);
    }
  }

  @override
  Future<Result<List<Product>>> getFavoriteProductsFull() async {
    return RepositoryCallHandler.call<List<Product>>(
        () => remoteDataSource.getFavoriteProductsFull().then((response) {
              return response.data.map((model) => model.toEntity()).toList();
            }));
  }

  @override
  Future<Result<List<Store>>> getFavoriteStoresFull() async {
    return RepositoryCallHandler.call<List<Store>>(
        () => remoteDataSource.getFavoriteStoresFull().then((response) {
              return response.data.map((model) => model.toEntity()).toList();
            }));
  }
}
