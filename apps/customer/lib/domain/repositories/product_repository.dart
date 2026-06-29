import 'package:core/error/result.dart';
import '../entities/product.dart';
import '../entities/common/paginated_data.dart';

abstract class ProductRepository {
  Future<Result<PaginatedData<Product>>> getProductsPaginated({
    int page = 1,
    int limit = 20,
  });

  Future<Result<List<Product>>> getProducts({
    int page = 1,
    int limit = 20,
  });

  Future<Result<PaginatedData<Product>>> getProductsByCategoryPaginated({
    required String categoryId,
    int page = 1,
    int limit = 20,
  });

  Future<Result<List<Product>>> getProductsByCategory({
    required String categoryId,
    int page = 1,
    int limit = 20,
  });

  Future<Result<Product>> getProductById(String productId);

  Future<Result<PaginatedData<Product>>> searchProductsPaginated({
    required String query,
    String? categoryId,
    double? minPrice,
    double? maxPrice,
    int page = 1,
    int limit = 20,
  });

  Future<Result<PaginatedData<Product>>> getFeaturedProductsPaginated({
    int page = 1,
    int limit = 20,
  });

  Future<Result<List<Product>>> getFeaturedProducts({
    int page = 1,
    int limit = 20,
  });

  Future<Result<PaginatedData<Product>>> getTrendingProductsPaginated({
    int page = 1,
    int limit = 20,
  });

  Future<Result<List<Product>>> getTrendingProducts({
    int page = 1,
    int limit = 20,
  });

  Future<Result<void>> toggleFavoriteProduct(String productId);

  Future<Result<PaginatedData<Product>>> getThriftProducts({
    String? categoryId,
    int page = 1,
    int limit = 20,
  });
}
