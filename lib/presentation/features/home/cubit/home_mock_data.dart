

import '../../../../domain/entities/address.dart';
import '../../../../domain/entities/category.dart';
import '../../../../domain/entities/product.dart';
import '../../../../domain/entities/special_offer.dart';
import '../../../../domain/entities/store.dart';

/// Mock data provider for Home screen
/// This will be replaced with real repository data in production
class HomeMockData {
  HomeMockData._(); // Private constructor to prevent instantiation

  // ========== CATEGORIES ==========

  static List<Category> getCategories() {
    return [
      const Category(id: 'all', name: 'All'),
      const Category(id: '1', name: 'Food'),
      const Category(id: '2', name: 'Drinks'),
      const Category(id: '3', name: 'Clothes'),
      const Category(id: '4', name: 'Electronics'),
      const Category(id: '5', name: 'Fashion'),
      const Category(id: '6', name: 'Home'),
    ];
  }

  // ========== PRODUCTS ==========

  static List<Product> getProducts() {
    return [
      Product(
        id: '1',
        name: 'Gold Stainless Steel Sun Charm Necklace',
        description: 'Beautiful gold necklace with sun charm. Perfect accessory for any occasion.',
        price: 7.00,
        discount: '30% OFF',
        images: ['assets/images/product_3.webp'],
        storeId: '1',
        categoryId: '3',
        currency: 'EG',
      ),
      Product(
        id: '2',
        name: 'Birthday Cake with Bows',
        description: 'Delicious birthday cake decorated with beautiful bows',
        price: 12.99,
        images: ['assets/images/product_3.webp'],
        storeId: '1',
        categoryId: '1',
        currency: 'EG',
      ),
      Product(
        id: '3',
        name: 'Chocolate Brownie',
        description: 'Rich, fudgy chocolate brownie made with premium cocoa',
        price: 10.99,
        images: ['assets/images/product_3.webp'],
        storeId: '2',
        categoryId: '1',
        currency: 'EG',
      ),
      Product(
        id: '4',
        name: 'Fresh Orange Juice',
        description: 'Freshly squeezed orange juice, 100% natural',
        price: 3.99,
        images: ['assets/images/product_3.webp'],
        storeId: '2',
        categoryId: '2',
        currency: 'EG',
      ),
      Product(
        id: '5',
        name: 'Wireless Headphones',
        description: 'Premium wireless headphones with noise cancellation',
        price: 49.99,
        discount: '15% OFF',
        images: ['assets/images/product_3.webp'],
        storeId: '3',
        categoryId: '4',
        currency: 'EG',
      ),
      Product(
        id: '6',
        name: 'Cotton T-Shirt',
        description: '100% cotton comfortable t-shirt in multiple colors',
        price: 15.99,
        images: ['assets/images/product_3.webp'],
        storeId: '1',
        categoryId: '3',
        currency: 'EG',
      ),
    ];
  }

  static List<Product> getTrendingProducts({int limit = 10}) {
    final products = getProducts();
    return products.take(limit).toList();
  }

  static List<Product> getProductsByCategory({
    required String categoryId,
    int limit = 10,
  }) {
    final products = getProducts();
    if (categoryId == 'all') {
      return products.take(limit).toList();
    }
    return products
        .where((product) => product.categoryId == categoryId)
        .take(limit)
        .toList();
  }

  static List<Product> searchProducts({
    required String query,
    int limit = 20,
  }) {
    final products = getProducts();
    final lowerQuery = query.toLowerCase();
    return products
        .where((product) =>
    product.name.toLowerCase().contains(lowerQuery) ||
        product.description.toLowerCase().contains(lowerQuery))
        .take(limit)
        .toList();
  }

  // ========== STORES ==========

  static List<Store> getStores() {
    return [
      Store(
        id: '1',
        name: 'Gold Gallery Accessories',
        description: 'Premium jewelry and accessories store with unique designs',
        coverImage: 'assets/images/store_sweet.webp',
        profileImage: 'assets/images/store_sweet.webp',
        sale: '25',
        rating: 4.5,
        address: const Address(
          id: '1',
          country: 'Iraq',
          city: 'Baghdad',
          latitude: 33.3152,
          longitude: 44.3661,
        ),
        contactInfo: ContactInfo(
          provider: 'gold@gallery.com',
          type: ContactType.email,
        ),
        categories: [
          const Category(id: '1', name: 'Jewelry'),
          const Category(id: '3', name: 'Clothes'),
        ],
      ),
      Store(
        id: '2',
        name: 'Sweet Cake Sweet',
        description: 'Delicious cakes and desserts made fresh daily',
        coverImage: 'assets/images/store_sweet.webp',
        profileImage: 'assets/images/store_sweet.webp',
        sale: '30',
        rating: 4.8,
        address: const Address(
          id: '2',
          country: 'Iraq',
          city: 'Baghdad',
          latitude: 33.3152,
          longitude: 44.3661,
        ),
        contactInfo: ContactInfo(
          provider: 'sweet@cake.com',
          type: ContactType.email,
        ),
        categories: [
          const Category(id: '1', name: 'Food'),
          const Category(id: '2', name: 'Drinks'),
        ],
      ),
      Store(
        id: '3',
        name: 'Techno Store',
        description: 'Latest tech gadgets and electronics',
        coverImage: 'assets/images/store_sweet.webp',
        profileImage: 'assets/images/store_sweet.webp',
        sale: '20',
        rating: 4.2,
        address: const Address(
          id: '3',
          country: 'Iraq',
          city: 'Baghdad',
          latitude: 33.3152,
          longitude: 44.3661,
        ),
        contactInfo: ContactInfo(
          provider: 'info@techno.com',
          type: ContactType.email,
        ),
        categories: [
          const Category(id: '4', name: 'Electronics'),
        ],
      ),
      Store(
        id: '4',
        name: 'Fashion Hub',
        description: 'Trendy fashion for everyone',
        coverImage: 'assets/images/store_sweet.webp',
        profileImage: 'assets/images/store_sweet.webp',
        sale: '15',
        rating: 4.6,
        address: const Address(
          id: '4',
          country: 'Iraq',
          city: 'Baghdad',
          latitude: 33.3152,
          longitude: 44.3661,
        ),
        contactInfo: ContactInfo(
          provider: 'contact@fashionhub.com',
          type: ContactType.email,
        ),
        categories: [
          const Category(id: '5', name: 'Fashion'),
          const Category(id: '3', name: 'Clothes'),
        ],
      ),
    ];
  }

  static List<Store> getTopStores({int limit = 10}) {
    final stores = getStores();
    // Sort by rating (descending)
    stores.sort((a, b) => b.rating.compareTo(a.rating));
    return stores.take(limit).toList();
  }

  // ========== SPECIAL OFFERS ==========

  static List<SpecialOffer> getSpecialOffers() {
    return [
      SpecialOffer(
        id: '1',
        title: 'Get 10% off on your first order',
        imageUrl:
        'https://img.freepik.com/free-psd/ocean-wave-crashing-sandy-beach-summer-vacation-paradise_191095-79314.jpg',
        discount: '25% OFF',
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 7)),
        createdAt: DateTime.now(),
      ),
      SpecialOffer(
        id: '2',
        title: 'Summer Sale - Up to 50% off',
        imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
        discount: '30% OFF',
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 7)),
        createdAt: DateTime.now(),
      ),
      SpecialOffer(
        id: '3',
        title: 'Weekend Special - Flash Deals',
        imageUrl: 'https://images.unsplash.com/photo-1558089551-95d707e6c13c',
        discount: '20% OFF',
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 2)),
        createdAt: DateTime.now(),
      ),
      SpecialOffer(
        id: '4',
        title: 'New Arrivals - Special Discount',
        imageUrl:
        'https://images.unsplash.com/photo-1441986300917-64674bd600d8',
        discount: '15% OFF',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 14)),
        createdAt: DateTime.now(),
      ),
    ];
  }

  // ========== USER INFO ==========

  static Map<String, dynamic> getUserInfo() {
    return {
      'name': 'John Doe',
      'location': 'Baghdad, Iraq',
      'email': 'john.doe@example.com',
      'phone': '+964 123 456 789',
    };
  }
}