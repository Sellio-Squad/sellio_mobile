import '../entities/product.dart';
import '../entities/category.dart';

abstract class ProductRepository {
  /// Get all products
  Future<List<Product>> getProducts({
    int page = 1,
    int limit = 20,
  });

  /// Get products by category
  Future<List<Product>> getProductsByCategory({
    required String categoryId,
    int page = 1,
    int limit = 20,
  });

  /// Get product details by ID
  Future<Product> getProductById(String productId);

  /// Search products
  Future<List<Product>> searchProducts({
    required String query,
    String? categoryId,
    double? minPrice,
    double? maxPrice,
    int page = 1,
    int limit = 20,
  });

  /// Get featured products
  Future<List<Product>> getFeaturedProducts({
    int page = 1,
    int limit = 20,
  });

  /// Get trending products
  Future<List<Product>> getTrendingProducts({
    int page = 1,
    int limit = 20,
  });

  /// Toggle favorite product
  Future<void> toggleFavoriteProduct(String productId);

  /// Get favorite products
  Future<List<Product>> getFavoriteProducts();

  /// Check if product is favorite
  Future<bool> isFavorite(String productId);
}