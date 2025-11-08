import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  // Mock data
  final List<Product> _mockProducts = [
    const Product(
      id: '1',
      name: 'Fresh Organic Apples',
      description: 'Delicious red apples from local farms',
      price: 4.99,
      currency: 'USD',
      discount: '10%',
      images: [
      ],
      categoryId: '1',
      storeId: 'store1',
      isAvailable: true,
      stockQuantity: 100,
    ),
    const Product(
      id: '2',
      name: 'Premium Coffee Beans',
      description: 'Arabica coffee beans, freshly roasted',
      price: 12.99,
      currency: 'USD',
      discount: '15%',
      images: [

      ],
      categoryId: '2',
      storeId: 'store1',
      isAvailable: true,
      stockQuantity: 50,
    ),
    const Product(
      id: '3',
      name: 'Cotton T-Shirt',
      description: 'Comfortable cotton t-shirt in multiple colors',
      price: 19.99,
      currency: 'USD',
      images: [

      ],
      categoryId: '3',
      storeId: 'store2',
      isAvailable: true,
      stockQuantity: 200,
    ),
    const Product(
      id: '4',
      name: 'Wireless Headphones',
      description: 'Noise-cancelling Bluetooth headphones',
      price: 79.99,
      currency: 'USD',
      discount: '20%',
      images: [

      ],
      categoryId: '4',
      storeId: 'store3',
      isAvailable: true,
      stockQuantity: 30,
    ),
    const Product(
      id: '5',
      name: 'Leather Wallet',
      description: 'Genuine leather wallet with RFID protection',
      price: 34.99,
      currency: 'USD',
      images: [

      ],
      categoryId: '5',
      storeId: 'store2',
      isAvailable: true,
      stockQuantity: 75,
    ),
    const Product(
      id: '6',
      name: 'Smart LED Bulb',
      description: 'WiFi-enabled color-changing LED bulb',
      price: 24.99,
      currency: 'USD',
      discount: '25%',
      images: [

      ],
      categoryId: '6',
      storeId: 'store3',
      isAvailable: true,
      stockQuantity: 120,
    ),
    const Product(
      id: '7',
      name: 'Orange Juice',
      description: 'Fresh squeezed orange juice',
      price: 5.99,
      currency: 'USD',
      images: [

      ],
      categoryId: '2',
      storeId: 'store1',
      isAvailable: true,
      stockQuantity: 80,
    ),
    const Product(
      id: '8',
      name: 'Running Shoes',
      description: 'Lightweight running shoes for athletes',
      price: 89.99,
      currency: 'USD',
      discount: '30%',
      images: [

      ],
      categoryId: '3',
      storeId: 'store2',
      isAvailable: true,
      stockQuantity: 45,
    ),
    const Product(
      id: '9',
      name: 'Smartphone Case',
      description: 'Protective case for smartphones',
      price: 14.99,
      currency: 'USD',
      images: [

      ],
      categoryId: '4',
      storeId: 'store3',
      isAvailable: false,
      stockQuantity: 0,
    ),
    const Product(
      id: '10',
      name: 'Yoga Mat',
      description: 'Non-slip yoga mat for home workouts',
      price: 29.99,
      currency: 'USD',
      discount: '5%',
      images: [

      ],
      categoryId: '6',
      storeId: 'store2',
      isAvailable: true,
      stockQuantity: 60,
    ),
  ];

  // In-memory favorites
  final Set<String> _favoriteProductIds = {};

  @override
  Future<List<Product>> getProducts({
    int page = 1,
    int limit = 20,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final startIndex = (page - 1) * limit;
    final endIndex = startIndex + limit;

    if (startIndex >= _mockProducts.length) {
      return [];
    }

    return _mockProducts.sublist(
      startIndex,
      endIndex > _mockProducts.length ? _mockProducts.length : endIndex,
    );
  }

  @override
  Future<List<Product>> getProductsByCategory({
    required String categoryId,
    int page = 1,
    int limit = 20,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final filtered = _mockProducts
        .where((p) => p.categoryId == categoryId)
        .toList();

    final startIndex = (page - 1) * limit;
    final endIndex = startIndex + limit;

    if (startIndex >= filtered.length) {
      return [];
    }

    return filtered.sublist(
      startIndex,
      endIndex > filtered.length ? filtered.length : endIndex,
    );
  }

  @override
  Future<Product> getProductById(String productId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return _mockProducts.firstWhere(
          (product) => product.id == productId,
      orElse: () => throw Exception('Product not found'),
    );
  }

  @override
  Future<List<Product>> searchProducts({
    required String query,
    String? categoryId,
    double? minPrice,
    double? maxPrice,
    int page = 1,
    int limit = 20,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final lowerQuery = query.toLowerCase();
    var results = _mockProducts.where((product) {
      final matchesQuery = product.name.toLowerCase().contains(lowerQuery) ||
          product.description.toLowerCase().contains(lowerQuery);

      final matchesCategory = categoryId == null || product.categoryId == categoryId;
      final matchesMinPrice = minPrice == null || product.price >= minPrice;
      final matchesMaxPrice = maxPrice == null || product.price <= maxPrice;

      return matchesQuery && matchesCategory && matchesMinPrice && matchesMaxPrice;
    }).toList();

    final startIndex = (page - 1) * limit;
    final endIndex = startIndex + limit;

    if (startIndex >= results.length) {
      return [];
    }

    return results.sublist(
      startIndex,
      endIndex > results.length ? results.length : endIndex,
    );
  }

  @override
  Future<List<Product>> getFeaturedProducts({
    int page = 1,
    int limit = 20,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    // Return products with discounts as featured
    final featured = _mockProducts
        .where((p) => p.discount != null && p.discount!.isNotEmpty)
        .toList();

    final startIndex = (page - 1) * limit;
    final endIndex = startIndex + limit;

    if (startIndex >= featured.length) {
      return [];
    }

    return featured.sublist(
      startIndex,
      endIndex > featured.length ? featured.length : endIndex,
    );
  }

  @override
  Future<List<Product>> getTrendingProducts({
    int page = 1,
    int limit = 20,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Return available products with discounts sorted by stock
    final trending = _mockProducts
        .where((p) => p.isAvailable && p.discount != null)
        .toList()
      ..sort((a, b) => b.stockQuantity.compareTo(a.stockQuantity));

    final startIndex = (page - 1) * limit;
    final endIndex = startIndex + limit;

    if (startIndex >= trending.length) {
      return [];
    }

    return trending.sublist(
      startIndex,
      endIndex > trending.length ? trending.length : endIndex,
    );
  }

  @override
  Future<void> toggleFavoriteProduct(String productId) async {
    await Future.delayed(const Duration(milliseconds: 200));

    if (_favoriteProductIds.contains(productId)) {
      _favoriteProductIds.remove(productId);
    } else {
      _favoriteProductIds.add(productId);
    }
  }

  @override
  Future<List<Product>> getFavoriteProducts() async {
    await Future.delayed(const Duration(milliseconds: 400));

    return _mockProducts
        .where((p) => _favoriteProductIds.contains(p.id))
        .toList();
  }

  @override
  Future<bool> isFavorite(String productId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _favoriteProductIds.contains(productId);
  }
}