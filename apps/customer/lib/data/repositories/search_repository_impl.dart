import 'package:core/error/result.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/search_repository.dart';
import '../core/utils/repository_call_handler.dart';
import '../datasource/local/search_local_datasource.dart';
import '../datasource/remote/search_remote_datasource.dart';
import 'package:sellio_mobile/data/mappers/store_mapper.dart';
import 'package:sellio_mobile/domain/entities/store.dart';
import 'package:design_system/design_system.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDateSource _remoteDataSource;
  final SearchLocalDatasource _localDataSource;

  SearchRepositoryImpl(
      {required SearchRemoteDateSource remoteDataSource,
      required SearchLocalDatasource localDataSource})
      : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<Result<List<Product>>> searchProducts({
    required String query,
    String? categoryId,
    double? minPrice,
    double? maxPrice,
    int page = 1,
    int limit = 20,
  }) async {
    return RepositoryCallHandler.call<List<Product>>(() async {
      final paginatedResponse = await _remoteDataSource.searchProducts(
        query: query,
        page: page - 1,
        pageSize: limit,
      );

      var products = paginatedResponse.data.map((m) => m.toEntity()).toList();

      if (categoryId != null) {
        products = products.where((p) => p.categoryId == categoryId).toList();
      }
      if (minPrice != null) {
        products = products.where((p) => p.minPrice >= minPrice).toList();
      }
      if (maxPrice != null) {
        products = products.where((p) => p.minPrice <= maxPrice).toList();
      }

      return products;
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
  Future<Result<List<String>>> getRecentSearches() async {
    return RepositoryCallHandler.call<List<String>>(() async {
      return await _localDataSource.getRecentSearch();
    });
  }

  @override
  Future<Result<void>> addToRecentSearch(String query) {
    return RepositoryCallHandler.call<void>(() async {
      await _localDataSource.addToRecentSearch(query);
    });
  }

  @override
  Future<Result<void>> clearAllRecentSearches() {
    return RepositoryCallHandler.call<void>(() async {
      await _localDataSource.clearAllRecentSearches();
    });
  }
}
