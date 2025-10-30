class StoreDataProvider {
  // ============================================================================
  // SINGLETON PATTERN
  // ============================================================================

  StoreDataProvider._();
  static final StoreDataProvider instance = StoreDataProvider._();
  factory StoreDataProvider() => instance;

  // ============================================================================
  // STORE CATEGORIES
  // ============================================================================

  List<String> getStoreCategories() {
    return ['All', 'Cakes', 'Cupcakes', 'Donuts'];
  }

  // ============================================================================
  // STORE DETAILS
  // ============================================================================

  String getStoreLocation(String storeId) {
    // TODO: Replace with actual API call
    return 'Baghdad, Iraq';
  }

  List<String> getStoreTags(String storeId) {
    // TODO: Replace with actual API call
    return ['Cake', 'Donut', 'Dessert'];
  }

  String getStoreDescription(String storeId) {
    // TODO: Replace with actual API call
    return 'Luxurious flavors, enchanting designs, and cakes made with love 💕\n'
        'Order your favorite cake from Cake by Heart now and enjoy your sweet moments 🍰';
  }

  StoreDetailsData getStoreDetails(String storeId) {
    return StoreDetailsData(
      location: getStoreLocation(storeId),
      tags: getStoreTags(storeId),
      description: getStoreDescription(storeId),
      categories: getStoreCategories(),
    );
  }

  // ============================================================================
  // PRODUCT DATA
  // ============================================================================

  /// Gets products by category index
  List<ProductData> getProductsByCategory(int categoryIndex) {
    // TODO: Replace with actual API call based on category
    return _getMockProducts();
  }

  /// Gets mock products data
  List<ProductData> _getMockProducts() {
    return [
      ProductData(
        id: 0,
        imageUrl: 'assets/images/product_1.png',
        title: 'Birthday cake with bows',
        description: 'Chocolate cake with vanilla frosting and decorative bows',
        price: '\$12.99',
        originalPrice: '\$15.99',
      ),
      ProductData(
        id: 1,
        imageUrl: 'assets/images/product_2.png',
        title: 'Strawberry Cupcake',
        description: 'Fresh strawberry cupcake with cream cheese frosting',
        price: '\$5.00',
        originalPrice: null,
      ),
      ProductData(
        id: 2,
        imageUrl: 'assets/images/product_3.png',
        title: 'Chocolate Donut',
        description: 'Classic chocolate donut with sprinkles',
        price: '\$3.50',
        originalPrice: '\$4.00',
      ),
    ];
  }
}

// ============================================================================
// DATA MODELS
// ============================================================================

class StoreDetailsData {
  final String location;
  final List<String> tags;
  final String description;
  final List<String> categories;

  StoreDetailsData({
    required this.location,
    required this.tags,
    required this.description,
    required this.categories,
  });
}

class ProductData {
  final int id;
  final String imageUrl;
  final String title;
  final String description;
  final String price;
  final String? originalPrice;

  ProductData({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    this.originalPrice,
  });

  // Factory constructor for JSON parsing (for future API integration)
  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'] as int,
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      originalPrice: json['originalPrice'] as String?,
    );
  }

  // Convert to JSON (for future API integration)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'price': price,
      'originalPrice': originalPrice,
    };
  }
}