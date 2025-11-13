import '../../core/error/result.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Result<List<Product>>> getProducts({
    int page = 1,
    int limit = 20,
  });

  Future<Result<List<Product>>> getProductsByCategory({
    required String categoryId,
    int page = 1,
    int limit = 20,
  });

  Future<Result<Product>> getProductById(String productId);

  Future<Result<List<Product>>> searchProducts({
    required String query,
    String? categoryId,
    double? minPrice,
    double? maxPrice,
    int page = 1,
    int limit = 20,
  });

  Future<Result<List<Product>>> getFeaturedProducts({
    int page = 1,
    int limit = 20,
  });

  Future<Result<List<Product>>> getTrendingProducts({
    int page = 1,
    int limit = 20,
  });

  Future<Result<void>> toggleFavoriteProduct(String productId);

  Future<Result<List<Product>>> getFavoriteProducts();

  Future<Result<bool>> isFavorite(String productId);
}