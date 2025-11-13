import '../../domain/core/result.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../core/utils/repository_call_handler.dart';
import '../core/storage/secure_storage.dart';
import '../datasources/local/favorites_local_datasource.dart';
import '../datasources/remote/favorites_remote_datasource.dart';
import '../datasources/remote/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;
  final FavoritesRemoteDataSource _favoritesRemoteDataSource;
  final FavoritesLocalDataSource _favoritesLocalDataSource;
  final SecureStorage _secureStorage;

  ProductRepositoryImpl({
    required ProductRemoteDataSource remoteDataSource,
    required FavoritesRemoteDataSource favoritesRemoteDataSource,
    required FavoritesLocalDataSource favoritesLocalDataSource,
    required SecureStorage secureStorage,
  })  : _remoteDataSource = remoteDataSource,
        _favoritesRemoteDataSource = favoritesRemoteDataSource,
        _favoritesLocalDataSource = favoritesLocalDataSource,
        _secureStorage = secureStorage;

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
            () => _secureStorage.getUserId(),
            (userId) async {
          // Update local first
          await _favoritesLocalDataSource.toggleProductFavorite(productId);

          try {
            // Sync with server
            await _favoritesRemoteDataSource.toggleProductFavorite(
              userId: userId,
              productId: productId,
            );
          } catch (e) {
            // Revert on error
            await _favoritesLocalDataSource.toggleProductFavorite(productId);
            rethrow;
          }
            },
    );
  }

  @override
  Future<Result<List<Product>>> getFavoriteProducts() async {
    return RepositoryCallHandler.callWithAuth<List<Product>>(
          () => _secureStorage.getUserId(),
          (userId) async {
        final productIds = await _favoritesRemoteDataSource
            .getFavoriteProductIds(userId);

        final products = <Product>[];
        for (final productId in productIds) {
          try {
            final model = await _remoteDataSource.getProductById(productId);
            products.add(model.toEntity());
          } catch (e) {
            continue; // Skip failed products
          }
        }

        return products;
      },
    );
  }

  @override
  Future<Result<bool>> isFavorite(String productId) async {
    return RepositoryCallHandler.call<bool>(
          () => _favoritesLocalDataSource.isProductFavorite(productId),
    );
  }
}