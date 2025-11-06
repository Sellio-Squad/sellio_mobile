import '../core/result.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  /// Get all products
  Future<Result<List<Product>>> getProducts({
    int page = 1,
    int limit = 20,
  });

  /// Get products by category
  Future<Result<List<Product>>> getProductsByCategory({
    required String categoryId,
    int page = 1,
    int limit = 20,
  });

  /// Get product details by ID
  Future<Result<Product>> getProductById(String productId);

  /// Search products
  Future<Result<List<Product>>> searchProducts({
    required String query,
    String? categoryId,
    double? minPrice,
    double? maxPrice,
    int page = 1,
    int limit = 20,
  });

  /// Get featured products
  Future<Result<List<Product>>> getFeaturedProducts({
    int page = 1,
    int limit = 20,
  });

  /// Get trending products
  Future<Result<List<Product>>> getTrendingProducts({
    int page = 1,
    int limit = 20,
  });

  /// Toggle favorite product
  Future<Result<void>> toggleFavoriteProduct(String productId);

  /// Get favorite products
  Future<Result<List<Product>>> getFavoriteProducts();

  /// Check if product is favorite
  Future<Result<bool>> isFavorite(String productId);
}