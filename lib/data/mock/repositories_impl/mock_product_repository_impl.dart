/*
import '../../../core/error/failure.dart';
import '../../../core/error/result.dart';
import '../../../domain/entities/common/paginated_data.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/repositories/product_repository.dart';
import '../mock_data_generator.dart';

class MockProductRepositoryImpl implements ProductRepository {
  final Set<String> _favoriteProductIds = {};

  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 600));
  }

  @override
  Future<Result<PaginatedData<Product>>> getProductsPaginated({
    int page = 1,
    int limit = 20,
  }) async {
    await _simulateDelay();

    final data = MockDataGenerator.generatePaginatedProducts(
      page: page - 1, // Convert to 0-based
      pageSize: limit,
    );

    return Success(data);
  }

  @override
  Future<Result<List<Product>>> getProducts({
    int page = 1,
    int limit = 20,
  }) async {
    await _simulateDelay();

    final products = MockDataGenerator.generateProducts(count: limit);
    return Success(products);
  }

  @override
  Future<Result<PaginatedData<Product>>> getProductsByCategoryPaginated({
    required String categoryId,
    int page = 1,
    int limit = 20,
  }) async {
    await _simulateDelay();

    final data = MockDataGenerator.generatePaginatedProducts(
      page: page - 1,
      pageSize: limit,
      categoryId: categoryId,
    );

    return Success(data);
  }

  @override
  Future<Result<List<Product>>> getProductsByCategory({
    required String categoryId,
    int page = 1,
    int limit = 20,
  }) async {
    await _simulateDelay();

    final products = MockDataGenerator.generateProducts(
      count: limit,
      categoryId: categoryId,
    );

    return Success(products);
  }

  // Continuing from MockProductRepositoryImpl

  @override
  Future<Result<Product>> getProductById(String productId) async {
    await _simulateDelay();

    final product = MockDataGenerator.generateProduct(
      index: int.tryParse(productId.replaceAll('product_', '')) ?? 0,
    );

    return Success(product);
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
    await _simulateDelay();

    if (query.isEmpty) {
      return const ResultFailure(
        ValidationFailure(message: 'Search query cannot be empty'),
      );
    }

    final data = MockDataGenerator.generatePaginatedProducts(
      page: page - 1,
      pageSize: limit,
      totalElements: 50,
      categoryId: categoryId,
    );

    return Success(data);
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
    await _simulateDelay();

    if (query.isEmpty) {
      return const ResultFailure(
        ValidationFailure(message: 'Search query cannot be empty'),
      );
    }

    final products = MockDataGenerator.generateProducts(
      count: limit,
      categoryId: categoryId,
    );

    return Success(products);
  }

  @override
  Future<Result<PaginatedData<Product>>> getFeaturedProductsPaginated({
    int page = 1,
    int limit = 20,
  }) async {
    await _simulateDelay();

    final data = MockDataGenerator.generatePaginatedProducts(
      page: page - 1,
      pageSize: limit,
      totalElements: 40,
    );

    return Success(data);
  }

  @override
  Future<Result<List<Product>>> getFeaturedProducts({
    int page = 1,
    int limit = 20,
  }) async {
    await _simulateDelay();

    final products = MockDataGenerator.generateProducts(count: limit);
    return Success(products);
  }

  @override
  Future<Result<PaginatedData<Product>>> getTrendingProductsPaginated({
    int page = 1,
    int limit = 20,
  }) async {
    await _simulateDelay();

    final data = MockDataGenerator.generatePaginatedProducts(
      page: page - 1,
      pageSize: limit,
      totalElements: 30,
    );

    return Success(data);
  }

  @override
  Future<Result<List<Product>>> getTrendingProducts({
    int page = 1,
    int limit = 20,
  }) async {
    await _simulateDelay();

    final products = MockDataGenerator.generateProducts(count: limit);
    return Success(products);
  }

  @override
  Future<Result<void>> toggleFavoriteProduct(String productId) async {
    await _simulateDelay();

    if (_favoriteProductIds.contains(productId)) {
      _favoriteProductIds.remove(productId);
    } else {
      _favoriteProductIds.add(productId);
    }

    return const Success(null);
  }

  @override
  Future<Result<List<Product>>> getFavoriteProducts() async {
    await _simulateDelay();

    final products = _favoriteProductIds
        .take(10)
        .map((id) => MockDataGenerator.generateProduct(
      index: int.tryParse(id.replaceAll('product_', '')) ?? 0,
    ))
        .toList();

    return Success(products);
  }

  @override
  Future<Result<bool>> isFavorite(String productId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return Success(_favoriteProductIds.contains(productId));
  }

  @override
  Future<Result<PaginatedData<Product>>> getThriftProducts({
    String? categoryId,
    int page = 1,
    int limit = 20,
  }) async {
    await _simulateDelay();

    final data = MockDataGenerator.generatePaginatedProducts(
      page: page - 1,
      pageSize: limit,
      totalElements: 60,
      categoryId: categoryId,
    );

    return Success(data);
  }
}*/
