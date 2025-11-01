class StoreDataProvider {

  StoreDataProvider._();
  static final StoreDataProvider instance = StoreDataProvider._();
  factory StoreDataProvider() => instance;

  List<String> getStoreCategories() {
    return ['All', 'Cakes', 'Cupcakes', 'Donuts'];
  }

  String getStoreLocation(String storeId) {
    return 'Baghdad, Iraq';
  }

  List<String> getStoreTags(String storeId) {
    return ['Cake', 'Donut', 'Dessert'];
  }

  String getStoreDescription(String storeId) {
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


  List<ProductData> getProductsByCategory(int categoryIndex) {
    return _getMockProducts();
  }

  List<ProductData> _getMockProducts() {
    return [
      ProductData(
        id: 0,
        imageUrl: 'assets/images/product_3.webp',
        title: 'Birthday cake with bows',
        description: 'Chocolate cake with vanilla frosting and decorative bows',
        price: '\$12.99',
        originalPrice: '\$15.99',
      ),
      ProductData(
        id: 1,
        imageUrl: 'assets/images/product_3.webp',
        title: 'Strawberry Cupcake',
        description: 'Fresh strawberry cupcake with cream cheese frosting',
        price: '\$5.00',
        originalPrice: null,
      ),
      ProductData(
        id: 2,
        imageUrl: 'assets/images/product_3.webp',
        title: 'Chocolate Donut',
        description: 'Classic chocolate donut with sprinkles',
        price: '\$3.50',
        originalPrice: '\$4.00',
      ),
    ];
  }
}

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
}