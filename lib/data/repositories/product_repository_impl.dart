import '../../core/error/result.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../core/storage/auth/auth_storage.dart';
import '../core/utils/repository_call_handler.dart';
import '../datasources/remote/favorites_remote_datasource.dart';
import '../datasources/remote/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;
  final FavoritesRemoteDataSource _favoritesRemoteDataSource;
  final AuthStorage _authStorage;

  ProductRepositoryImpl({
    required ProductRemoteDataSource remoteDataSource,
    required FavoritesRemoteDataSource favoritesRemoteDataSource,
    required AuthStorage authStorage,
  })  : _remoteDataSource = remoteDataSource,
        _favoritesRemoteDataSource = favoritesRemoteDataSource,
        _authStorage = authStorage;

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
  Future<Result<Product>> getProductById(String productId) async {
    return RepositoryCallHandler.call<Product>(() async {
      final productModel = await _remoteDataSource.getProductById(productId);
      return productModel.toEntity();
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

      // Client-side filters
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
  Future<Result<void>> toggleFavoriteProduct(String productId) async {
    return RepositoryCallHandler.callWithAuth<void>(
          () => _authStorage.getUserId(),
          (userId) => _favoritesRemoteDataSource.toggleProductFavorite(
        userId: userId,
        productId: productId,
      ),
    );
  }

  @override
  Future<Result<List<Product>>> getFavoriteProducts() async {
    return RepositoryCallHandler.callWithAuth<List<Product>>(
          () => _authStorage.getUserId(),
          (userId) async {
        final productIds = await _favoritesRemoteDataSource.getFavoriteProductIds(userId);

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
      },
    );
  }

  @override
  Future<Result<bool>> isFavorite(String productId) async {
    return RepositoryCallHandler.callWithAuth<bool>(
          () => _authStorage.getUserId(),
          (userId) async {
        final favoriteIds = await _favoritesRemoteDataSource.getFavoriteProductIds(userId);
        return favoriteIds.contains(productId);
      },
    );
  }
}