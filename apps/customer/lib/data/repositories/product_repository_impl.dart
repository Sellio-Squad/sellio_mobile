import '../../core/error/result.dart';
import '../../domain/entities/common/paginated_data.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../core/utils/repository_call_handler.dart';
import '../datasource/remote/favorites_remote_datasource.dart';
import '../datasource/remote/product_remote_datasource.dart';
import '../models/common/paginated_response.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;
  final FavoritesRemoteDataSource _favoritesRemoteDataSource;

  ProductRepositoryImpl({
    required ProductRemoteDataSource remoteDataSource,
    required FavoritesRemoteDataSource favoritesRemoteDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _favoritesRemoteDataSource = favoritesRemoteDataSource;


  @override
  Future<Result<PaginatedData<Product>>> getProductsPaginated({
    int page = 1,
    int limit = 20,
  }) async {
    return RepositoryCallHandler.call<PaginatedData<Product>>(() async {
      final paginatedResponse = await _remoteDataSource.getProducts(
        page: page - 1,
        pageSize: limit,
      );
      return _mapToPaginatedData(paginatedResponse);
    });
  }

  @override
  Future<Result<PaginatedData<Product>>> getProductsByCategoryPaginated({
    required String categoryId,
    int page = 1,
    int limit = 20,
  }) async {
    return RepositoryCallHandler.call<PaginatedData<Product>>(() async {
      final paginatedResponse = await _remoteDataSource.getProductsByCategory(
        categoryId: categoryId,
        page: page - 1,
        pageSize: limit,
      );
      return _mapToPaginatedData(paginatedResponse);
    });
  }

  @override
  Future<Result<PaginatedData<Product>>> searchProductsPaginated({
    required String query,
    String? categoryId,
    double? minPrice,
    double? maxPrice,
    int page = 1,
    int limit = 20,
  }) async {
    return RepositoryCallHandler.call<PaginatedData<Product>>(() async {
      final paginatedResponse = await _remoteDataSource.searchProducts(
        query: query,
        page: page - 1,
        pageSize: limit,
      );

      var paginatedData = _mapToPaginatedData(paginatedResponse);

      var filteredProducts = paginatedData.items;
      if (categoryId != null) {
        filteredProducts = filteredProducts.where((p) => p.categoryId == categoryId).toList();
      }
      if (minPrice != null) {
        filteredProducts = filteredProducts.where((p) => p.price >= minPrice).toList();
      }
      if (maxPrice != null) {
        filteredProducts = filteredProducts.where((p) => p.price <= maxPrice).toList();
      }

      return paginatedData.copyWith(
        items: filteredProducts,
        totalElements: filteredProducts.length,
      );
    });
  }

  @override
  Future<Result<PaginatedData<Product>>> getFeaturedProductsPaginated({
    int page = 1,
    int limit = 20,
  }) async {
    return RepositoryCallHandler.call<PaginatedData<Product>>(() async {
      final paginatedResponse = await _remoteDataSource.getFeaturedProducts(
        page: page - 1,
        pageSize: limit,
      );
      return _mapToPaginatedData(paginatedResponse);
    });
  }

  @override
  Future<Result<PaginatedData<Product>>> getTrendingProductsPaginated({
    int page = 1,
    int limit = 20,
  }) async {
    return RepositoryCallHandler.call<PaginatedData<Product>>(() async {
      final paginatedResponse = await _remoteDataSource.getTrendingProducts(
        page: page - 1,
        pageSize: limit,
      );
      return _mapToPaginatedData(paginatedResponse);
    });
  }

  @override
  Future<Result<List<Product>>> getProducts({
    int page = 1,
    int limit = 20,
  }) async {
    return RepositoryCallHandler.call<List<Product>>(() async {
      final paginatedResponse = await _remoteDataSource.getProducts(
        page: page - 1,
        pageSize: limit,
      );
      return paginatedResponse.data.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Result<List<Product>>> getProductsByCategory({
    required String categoryId,
    int page = 1,
    int limit = 20,
  }) async {
    return RepositoryCallHandler.call<List<Product>>(() async {
      final paginatedResponse = await _remoteDataSource.getProductsByCategory(
        categoryId: categoryId,
        page: page - 1,
        pageSize: limit,
      );
      return paginatedResponse.data.map((model) => model.toEntity()).toList();
    });
  }

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
        products = products.where((p) => p.price >= minPrice).toList();
      }
      if (maxPrice != null) {
        products = products.where((p) => p.price <= maxPrice).toList();
      }

      return products;
    });
  }

  @override
  Future<Result<List<Product>>> getFeaturedProducts({
    int page = 1,
    int limit = 20,
  }) async {
    return RepositoryCallHandler.call<List<Product>>(() async {
      final paginatedResponse = await _remoteDataSource.getFeaturedProducts(
        page: page - 1,
        pageSize: limit,
      );
      return paginatedResponse.data.map((model) => model.toEntity()).toList();
    });
  }

  @override
  Future<Result<List<Product>>> getTrendingProducts({
    int page = 1,
    int limit = 20,
  }) async {
    return RepositoryCallHandler.call<List<Product>>(() async {
      final paginatedResponse = await _remoteDataSource.getTrendingProducts(
        page: page - 1,
        pageSize: limit,
      );
      return paginatedResponse.data.map((model) => model.toEntity()).toList();
    });
  }


  @override
  Future<Result<Product>> getProductById(String productId) async {
    return RepositoryCallHandler.call<Product>(() async {
      final productModel = await _remoteDataSource.getProductById(productId);
      return productModel.toEntity();
    });
  }

  @override
  Future<Result<void>> toggleFavoriteProduct(String productId) async {
    return RepositoryCallHandler.call<void>(
          () => _favoritesRemoteDataSource.toggleProductFavorite(
        productId: productId,
      ),
    );
  }

  @override
  Future<Result<List<Product>>> getFavoriteProducts() async {
    return RepositoryCallHandler.call<List<Product>>(() async {
      final productIds = await _favoritesRemoteDataSource.getFavoriteProductIds();

      final products = <Product>[];
      for (final productId in productIds) {
        try {
          final model = await _remoteDataSource.getProductById(productId);
          products.add(model.toEntity());
        } catch (e) {
          continue;
        }
      }

      return products;
    });
  }

  @override
  Future<Result<bool>> isFavorite(String productId) async {
    return RepositoryCallHandler.call<bool>(() async {
      final favoriteIds = await _favoritesRemoteDataSource.getFavoriteProductIds();
      return favoriteIds.contains(productId);
    });
  }


  PaginatedData<Product> _mapToPaginatedData(
      PaginatedResponse<ProductModel> response,
      ) {
    return PaginatedData<Product>(
      items: response.data.map((model) => model.toEntity()).toList(),
      totalElements: response.totalElements,
      currentPage: response.page + 1,
      pageSize: response.pageSize,
      totalPages: response.totalPages,
    );
  }
  @override
  Future<Result<PaginatedData<Product>>> getThriftProducts({
    String? categoryId,
    int page = 1,
    int limit = 20,
  }) async {
    return RepositoryCallHandler.call<PaginatedData<Product>>(() async {
      final normalizedCategoryId =
          (categoryId == null || categoryId.isEmpty) ? null : categoryId;
      final paginatedResponse = await _remoteDataSource.getThriftProducts(
        categoryId: normalizedCategoryId,
        page: page - 1,
        pageSize: limit,
      );

      return _mapToPaginatedData(paginatedResponse);
    });
  }

}
