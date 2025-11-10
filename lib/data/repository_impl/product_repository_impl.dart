import '../../domain/core/failure.dart';
import '../../domain/core/result.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/local/product_local_datasource.dart';
import '../datasources/remote/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;
  final ProductLocalDataSource _localDataSource;

  ProductRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Result<List<Product>>> getProducts(
      {int page = 1, int limit = 20}) async {
    try {
      // Try to fetch from remote
      final products =
          await _remoteDataSource.getProducts(page: page, limit: limit);

      // Cache the products
      await _localDataSource.cacheProducts(products);

      return Success(products.map((model) => model.toEntity()).toList());
    } catch (e) {
      // If remote fails, try to get from cache
      try {
        final cachedProducts = await _localDataSource.getCachedProducts();
        if (cachedProducts.isNotEmpty) {
          return Success(
              cachedProducts.map((model) => model.toEntity()).toList());
        }
      } catch (cacheError) {
        // Cache also failed
      }

      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<List<Product>>> getProductsByCategory({
    required String categoryId,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final products = await _remoteDataSource.getProductsByCategory(
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
  Future<Result<Product>> getProductById(String productId) async {
    try {
      final product = await _remoteDataSource.getProductById(productId);

      // Cache the product
      await _localDataSource.cacheProduct(product);

      return Success(product.toEntity());
    } catch (e) {
      // Try to get from cache
      try {
        final cachedProduct =
            await _localDataSource.getCachedProductById(productId);
        if (cachedProduct != null) {
          return Success(cachedProduct.toEntity());
        }
      } catch (cacheError) {
        // Cache failed
      }

      return ResultFailure(_mapExceptionToFailure(e));
    }
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
    try {
      final products = await _remoteDataSource.searchProducts(
        query: query,
        categoryId: categoryId,
        minPrice: minPrice,
        maxPrice: maxPrice,
        page: page,
        limit: limit,
      );

      return Success(products.map((model) => model.toEntity()).toList());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<List<Product>>> getFeaturedProducts(
      {int page = 1, int limit = 20}) async {
    try {
      final products =
          await _remoteDataSource.getFeaturedProducts(page: page, limit: limit);
      return Success(products.map((model) => model.toEntity()).toList());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<List<Product>>> getTrendingProducts(
      {int page = 1, int limit = 20}) async {
    try {
      final products =
          await _remoteDataSource.getTrendingProducts(page: page, limit: limit);
      return Success(products.map((model) => model.toEntity()).toList());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<void>> toggleFavoriteProduct(String productId) async {
    try {
      await _remoteDataSource.toggleFavoriteProduct(productId);

      // Update local favorite status
      final isFavorite = await _localDataSource.isFavoriteProduct(productId);
      if (isFavorite) {
        await _localDataSource.removeFavoriteProduct(productId);
      } else {
        await _localDataSource.addFavoriteProduct(productId);
      }

      return const Success(null);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<List<Product>>> getFavoriteProducts() async {
    try {
      final products = await _remoteDataSource.getFavoriteProducts();
      return Success(products.map((model) => model.toEntity()).toList());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<bool>> isFavorite(String productId) async {
    try {
      final isFavorite = await _localDataSource.isFavoriteProduct(productId);
      return Success(isFavorite);
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
