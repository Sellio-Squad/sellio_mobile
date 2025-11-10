import '../../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();

  Future<void> cacheProducts(List<ProductModel> products);

  Future<ProductModel?> getCachedProductById(String productId);

  Future<void> cacheProduct(ProductModel product);

  Future<void> clearProductsCache();

  Future<List<String>> getFavoriteProductIds();

  Future<void> addFavoriteProduct(String productId);

  Future<void> removeFavoriteProduct(String productId);

  Future<bool> isFavoriteProduct(String productId);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  List<ProductModel> _cachedProducts = [];
  final Set<String> _favoriteProductIds = {};

  ProductLocalDataSourceImpl() {
    // Initialize with fake products
    _cachedProducts = _getFakeProducts();
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    if (_cachedProducts.isEmpty) {
      _cachedProducts = _getFakeProducts();
    }
    return _cachedProducts;
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    _cachedProducts = products;
  }

  @override
  Future<ProductModel?> getCachedProductById(String productId) async {
    final products = await getCachedProducts();
    try {
      return products.firstWhere((product) => product.id == productId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheProduct(ProductModel product) async {
    final index = _cachedProducts.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _cachedProducts[index] = product;
    } else {
      _cachedProducts.add(product);
    }
  }

  @override
  Future<void> clearProductsCache() async {
    _cachedProducts = [];
  }

  @override
  Future<List<String>> getFavoriteProductIds() async {
    return _favoriteProductIds.toList();
  }

  @override
  Future<void> addFavoriteProduct(String productId) async {
    _favoriteProductIds.add(productId);
  }

  @override
  Future<void> removeFavoriteProduct(String productId) async {
    _favoriteProductIds.remove(productId);
  }

  @override
  Future<bool> isFavoriteProduct(String productId) async {
    return _favoriteProductIds.contains(productId);
  }

  // Fake products data
  List<ProductModel> _getFakeProducts() {
    return [
      ProductModel(
        id: 'prod_001',
        name: 'Smartphone Pro Max',
        description: 'Latest smartphone with advanced features and great camera',
        price: 999.99,
        currency: 'USD',
        discount: '10% OFF',
        images: [
          'https://via.placeholder.com/400x400',
          'https://via.placeholder.com/400x400',
        ],
        storeId: 'store_001',
        categoryId: 'cat_001',
        isAvailable: true,
        stockQuantity: 50,
      ),
      ProductModel(
        id: 'prod_002',
        name: 'Laptop Ultra',
        description: 'High-performance laptop for work and gaming',
        price: 1499.99,
        currency: 'USD',
        images: [
          'https://via.placeholder.com/400x400',
        ],
        storeId: 'store_001',
        categoryId: 'cat_002',
        isAvailable: true,
        stockQuantity: 30,
      ),
      ProductModel(
        id: 'prod_003',
        name: 'Designer T-Shirt',
        description: 'Comfortable and stylish t-shirt',
        price: 29.99,
        currency: 'USD',
        discount: 'Buy 2 Get 1 Free',
        images: [
          'https://via.placeholder.com/400x400',
          'https://via.placeholder.com/400x400',
          'https://via.placeholder.com/400x400',
        ],
        storeId: 'store_002',
        categoryId: 'cat_003',
        isAvailable: true,
        stockQuantity: 100,
      ),
      ProductModel(
        id: 'prod_004',
        name: 'Leather Handbag',
        description: 'Elegant leather handbag for everyday use',
        price: 199.99,
        currency: 'USD',
        images: [
          'https://via.placeholder.com/400x400',
          'https://via.placeholder.com/400x400',
        ],
        storeId: 'store_002',
        categoryId: 'cat_004',
        isAvailable: true,
        stockQuantity: 25,
      ),
      ProductModel(
        id: 'prod_005',
        name: 'Coffee Table',
        description: 'Modern coffee table for your living room',
        price: 299.99,
        currency: 'USD',
        images: [
          'https://via.placeholder.com/400x400',
        ],
        storeId: 'store_003',
        categoryId: 'cat_005',
        isAvailable: true,
        stockQuantity: 15,
      ),
      ProductModel(
        id: 'prod_006',
        name: 'Garden Tools Set',
        description: 'Complete set of gardening tools',
        price: 79.99,
        currency: 'USD',
        images: [
          'https://via.placeholder.com/400x400',
          'https://via.placeholder.com/400x400',
        ],
        storeId: 'store_003',
        categoryId: 'cat_006',
        isAvailable: true,
        stockQuantity: 40,
      ),
    ];
  }
}
