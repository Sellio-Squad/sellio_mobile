// lib/data/repositories/store_repository_impl.dart
import '../../domain/entities/store.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/review.dart';
import '../../domain/entities/address.dart';
import '../../domain/entities/category.dart';
import '../../domain/repositories/store_repository.dart';

class StoreRepositoryImpl implements StoreRepository {
  // Mock data
  final List<Store> _mockStores = [
    Store(
      id: 'store1',
      name: 'Fresh Market',
      description: 'Your local organic market with fresh produce and groceries',
      profileImage: 'https://images.unsplash.com/photo-1534723328310-e82dad3ee43f?w=200',
      coverImage: 'https://images.unsplash.com/photo-1543168256-418811576931?w=400',
      sale: '20% OFF',
      rating: 4.7,
      address: const Address(
        id: 'addr1',
        country: 'United States',
        city: 'New York',
        latitude: 40.7128,
        longitude: -74.0060,
      ),
      contactInfo: ContactInfo(
        provider: 'contact@freshmarket.com',
        type: ContactType.email,
      ),
      categories: const [
        Category(id: '1', name: 'Food', ),
        Category(id: '2', name: 'Drinks', ),
      ],
      reviews: [
        Review(
          id: 'review1',
          storeId: 'store1',
          userId: 'user1',
          userName: 'John Doe',
          userImage: 'https://i.pravatar.cc/100?img=1',
          rating: 5.0,
          comment: 'Great store! Fresh products and excellent service.',
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
        Review(
          id: 'review2',
          storeId: 'store1',
          userId: 'user2',
          userName: 'Sarah Johnson',
          userImage: 'https://i.pravatar.cc/100?img=2',
          rating: 4.5,
          comment: 'Good quality products, reasonable prices.',
          createdAt: DateTime.now().subtract(const Duration(days: 12)),
        ),
      ],
      isActive: true,
    ),
    Store(
      id: 'store2',
      name: 'Fashion Hub',
      description: 'Trendy fashion for everyone. Latest styles and designs',
      profileImage: 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=200',
      coverImage: 'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?w=400',
      sale: '15% OFF',
      rating: 4.5,
      address: const Address(
        id: 'addr2',
        country: 'United States',
        city: 'Los Angeles',
        latitude: 34.0522,
        longitude: -118.2437,
      ),
      contactInfo: ContactInfo(
        provider: '+1234567891',
        type: ContactType.phone,
      ),
      categories: const [
        Category(id: '3', name: 'Clothes',),
        Category(id: '5', name: 'Fashion', ),
      ],
      reviews: [
        Review(
          id: 'review3',
          storeId: 'store2',
          userId: 'user3',
          userName: 'Mike Wilson',
          userImage: 'https://i.pravatar.cc/100?img=3',
          rating: 4.0,
          comment: 'Nice collection, but a bit pricey.',
          createdAt: DateTime.now().subtract(const Duration(days: 8)),
        ),
      ],
      isActive: true,
    ),
    Store(
      id: 'store3',
      name: 'Tech World',
      description: 'Latest gadgets and electronics. Your tech destination',
      profileImage: 'https://images.unsplash.com/photo-1531482615713-2afd69097998?w=200',
      coverImage: 'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=400',
      sale: '25% OFF',
      rating: 4.8,
      address: const Address(
        id: 'addr3',
        country: 'United States',
        city: 'San Francisco',
        latitude: 37.7749,
        longitude: -122.4194,
      ),
      contactInfo: ContactInfo(
        provider: 'support@techworld.com',
        type: ContactType.email,
      ),
      categories: const [
        Category(id: '4', name: 'Electronics',),
        Category(id: '6', name: 'Home', ),
      ],
      reviews: [
        Review(
          id: 'review4',
          storeId: 'store3',
          userId: 'user4',
          userName: 'Jane Smith',
          userImage: 'https://i.pravatar.cc/100?img=4',
          rating: 5.0,
          comment: 'Best tech store! Fast delivery and great customer support.',
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
        ),
        Review(
          id: 'review5',
          storeId: 'store3',
          userId: 'user5',
          userName: 'David Brown',
          userImage: 'https://i.pravatar.cc/100?img=5',
          rating: 4.5,
          comment: 'Good products, fast delivery.',
          createdAt: DateTime.now().subtract(const Duration(days: 10)),
        ),
        Review(
          id: 'review6',
          storeId: 'store3',
          userId: 'user6',
          userName: 'Emily Davis',
          userImage: 'https://i.pravatar.cc/100?img=6',
          rating: 5.0,
          comment: 'Amazing store! Highly recommend.',
          createdAt: DateTime.now().subtract(const Duration(days: 15)),
        ),
      ],
      isActive: true,
    ),
    Store(
      id: 'store4',
      name: 'Home Decor',
      description: 'Beautiful items for your home. Transform your living space',
      profileImage: 'https://images.unsplash.com/photo-1513694203232-719a280e022f?w=200',
      coverImage: 'https://images.unsplash.com/photo-1556912172-45b7abe8b7e1?w=400',
      sale: '10% OFF',
      rating: 4.4,
      address: const Address(
        id: 'addr4',
        country: 'United States',
        city: 'Chicago',
        latitude: 41.8781,
        longitude: -87.6298,
      ),
      contactInfo: ContactInfo(
        provider: 'https://homedecor.com',
        type: ContactType.website,
      ),
      categories: const [
        Category(id: '6', name: 'Home', ),
      ],
      reviews: [
        Review(
          id: 'review7',
          storeId: 'store4',
          userId: 'user7',
          userName: 'Lisa Anderson',
          userImage: 'https://i.pravatar.cc/100?img=7',
          rating: 4.5,
          comment: 'Beautiful decorations! Will buy again.',
          createdAt: DateTime.now().subtract(const Duration(days: 6)),
        ),
      ],
      isActive: true,
    ),
    Store(
      id: 'store5',
      name: 'Sports Arena',
      description: 'Everything for sports enthusiasts. Quality sports gear',
      profileImage: 'https://images.unsplash.com/photo-1587280501635-68a0e82cd5ff?w=200',
      coverImage: 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?w=400',
      sale: '30% OFF',
      rating: 4.6,
      address: const Address(
        id: 'addr5',
        country: 'United States',
        city: 'Miami',
        latitude: 25.7617,
        longitude: -80.1918,
      ),
      contactInfo: ContactInfo(
        provider: '+1234567894',
        type: ContactType.whatsapp,
      ),
      categories: const [
        Category(id: '3', name: 'Clothes',),
      ],
      reviews: [
        Review(
          id: 'review8',
          storeId: 'store5',
          userId: 'user8',
          userName: 'Tom Harris',
          userImage: 'https://i.pravatar.cc/100?img=8',
          rating: 4.5,
          comment: 'Great sports equipment!',
          createdAt: DateTime.now().subtract(const Duration(days: 4)),
        ),
        Review(
          id: 'review9',
          storeId: 'store5',
          userId: 'user9',
          userName: 'Anna Martinez',
          rating: 5.0,
          comment: 'Perfect for all my sports needs.',
          createdAt: DateTime.now().subtract(const Duration(days: 9)),
        ),
      ],
      isActive: true,
    ),
  ];

  // Reference products
  final List<Product> _mockProducts = [
    const Product(
      id: '1',
      name: 'Fresh Organic Apples',
      description: 'Delicious red apples',
      price: 4.99,
      currency: 'USD',
      discount: '10%',
      images: ['https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=400'],
      categoryId: '1',
      storeId: 'store1',
      isAvailable: true,
      stockQuantity: 100,
    ),
    const Product(
      id: '2',
      name: 'Premium Coffee Beans',
      description: 'Arabica coffee beans',
      price: 12.99,
      currency: 'USD',
      images: ['https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=400'],
      categoryId: '2',
      storeId: 'store1',
      isAvailable: true,
      stockQuantity: 50,
    ),
    const Product(
      id: '3',
      name: 'Cotton T-Shirt',
      description: 'Comfortable t-shirt',
      price: 19.99,
      currency: 'USD',
      images: ['https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400'],
      categoryId: '3',
      storeId: 'store2',
      isAvailable: true,
      stockQuantity: 200,
    ),
    const Product(
      id: '4',
      name: 'Wireless Headphones',
      description: 'Noise-cancelling headphones',
      price: 79.99,
      currency: 'USD',
      discount: '20%',
      images: ['https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400'],
      categoryId: '4',
      storeId: 'store3',
      isAvailable: true,
      stockQuantity: 30,
    ),
  ];

  // In-memory favorites
  final Set<String> _favoriteStoreIds = {};

  @override
  Future<List<Store>> getStores({
    int page = 1,
    int limit = 20,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final startIndex = (page - 1) * limit;
    final endIndex = startIndex + limit;

    if (startIndex >= _mockStores.length) {
      return [];
    }

    return _mockStores.sublist(
      startIndex,
      endIndex > _mockStores.length ? _mockStores.length : endIndex,
    );
  }

  @override
  Future<Store> getStoreById(String storeId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return _mockStores.firstWhere(
          (store) => store.id == storeId,
      orElse: () => throw Exception('Store not found'),
    );
  }

  @override
  Future<List<Store>> getTopStores({
    int limit = 10,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Sort by rating and return top stores
    final topStores = _mockStores.toList()
      ..sort((a, b) => b.rating.compareTo(a.rating));

    return topStores.take(limit).toList();
  }

  @override
  Future<List<Product>> getStoreProducts({
    required String storeId,
    String? categoryId,
    int page = 1,
    int limit = 20,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    var filtered = _mockProducts.where((p) => p.storeId == storeId);

    if (categoryId != null) {
      filtered = filtered.where((p) => p.categoryId == categoryId);
    }

    final products = filtered.toList();

    final startIndex = (page - 1) * limit;
    final endIndex = startIndex + limit;

    if (startIndex >= products.length) {
      return [];
    }

    return products.sublist(
      startIndex,
      endIndex > products.length ? products.length : endIndex,
    );
  }

  @override
  Future<List<Product>> getStoreFeaturedProducts({
    required String storeId,
    int limit = 10,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final featured = _mockProducts
        .where((p) => p.storeId == storeId && p.discount != null)
        .toList();

    return featured.take(limit).toList();
  }

  @override
  Future<List<Store>> searchStores({
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final lowerQuery = query.toLowerCase();
    final results = _mockStores.where((store) {
      return store.name.toLowerCase().contains(lowerQuery) ||
          store.description.toLowerCase().contains(lowerQuery);
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
  Future<void> toggleFavoriteStore(String storeId) async {
    await Future.delayed(const Duration(milliseconds: 200));

    if (_favoriteStoreIds.contains(storeId)) {
      _favoriteStoreIds.remove(storeId);
    } else {
      _favoriteStoreIds.add(storeId);
    }
  }

  @override
  Future<List<Store>> getFavoriteStores() async {
    await Future.delayed(const Duration(milliseconds: 400));

    return _mockStores
        .where((s) => _favoriteStoreIds.contains(s.id))
        .toList();
  }

  @override
  Future<bool> isFavorite(String storeId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _favoriteStoreIds.contains(storeId);
  }

  @override
  Future<List<Review>> getStoreReviews({
    required String storeId,
    int page = 1,
    int limit = 20,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final store = await getStoreById(storeId);

    final startIndex = (page - 1) * limit;
    final endIndex = startIndex + limit;

    if (startIndex >= store.reviews.length) {
      return [];
    }

    return store.reviews.sublist(
      startIndex,
      endIndex > store.reviews.length ? store.reviews.length : endIndex,
    );
  }

  @override
  Future<StoreRating> getStoreRating(String storeId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final store = await getStoreById(storeId);
    final totalReviews = store.reviews.length;

    // Calculate rating distribution
    final distribution = <int, int>{
      5: 0,
      4: 0,
      3: 0,
      2: 0,
      1: 0,
    };

    for (var review in store.reviews) {
      final ratingKey = review.rating.round();
      distribution[ratingKey] = (distribution[ratingKey] ?? 0) + 1;
    }

    return StoreRating(
      storeId: storeId,
      averageRating: store.rating,
      totalReviews: totalReviews,
      ratingDistribution: distribution,
    );
  }

  @override
  Future<Review> addStoreReview({
    required String storeId,
    required double rating,
    String? comment,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final newReview = Review(
      id: 'review_${DateTime.now().millisecondsSinceEpoch}',
      storeId: storeId,
      userId: 'current_user',
      userName: 'Current User',
      userImage: 'https://i.pravatar.cc/100?img=10',
      rating: rating,
      comment: comment,
      createdAt: DateTime.now(),
    );

    // In a real implementation, you would update the store's reviews
    // For now, just return the new review
    return newReview;
  }
}