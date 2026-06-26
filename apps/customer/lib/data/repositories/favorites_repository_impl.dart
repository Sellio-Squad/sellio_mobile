import 'package:core/error/result.dart';
import 'package:sellio_mobile/domain/entities/product.dart';

import '../../domain/entities/store.dart';
import '../../domain/repositories/favorites_repository.dart';
import 'package:core/core.dart';
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
  Future<void> toggleProductFavorite(String productId) async {
    await remoteDataSource.toggleProductFavorite(productId: productId);
  }

  @override
  Future<void> toggleStoreFavorite(String storeId) async {
    await remoteDataSource.toggleStoreFavorite(storeId: storeId);
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
