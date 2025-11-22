import 'dart:math';
import '../../domain/entities/address.dart';
import '../../domain/entities/cart.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/notification.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/review.dart';
import '../../domain/entities/special_offer.dart';
import '../../domain/entities/store.dart';
import '../../domain/entities/store_rating.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/common/paginated_data.dart';

class MockDataGenerator {
  static final Random _random = Random();

  // User Mock Data
  static User generateUser({int index = 0}) {
    return User(
      fullName: 'John Doe $index',
      phoneNumber: '555${_random.nextInt(1000000).toString().padLeft(7, '0')}',
      countryCode: '+1',
      profilePhotoUrl: 'https://i.pravatar.cc/150?img=$index',
      address: generateAddress(index: index),
    );
  }

  // Address Mock Data
  static Address generateAddress({int index = 0}) {
    final cities = ['New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix'];
    final countries = ['USA', 'Canada', 'UK', 'Australia', 'Germany'];

    return Address(
      id: 'address_$index',
      country: countries[index % countries.length],
      city: cities[index % cities.length],
    );
  }

  static List<Address> generateAddresses({int count = 3}) {
    return List.generate(count, (i) => generateAddress(index: i));
  }

  // Category Mock Data
  static Category generateCategory({int index = 0}) {
    final categories = ['Electronics', 'Fashion', 'Home & Garden', 'Sports', 'Books', 'Toys', 'Beauty', 'Automotive'];

    return Category(
      id: 'category_$index',
      name: categories[index % categories.length],
    );
  }

  static List<Category> generateCategories({int count = 8}) {
    return List.generate(count, (i) => generateCategory(index: i));
  }

  // Product Mock Data
  static Product generateProduct({int index = 0, String? categoryId, String? storeId}) {
    final productNames = [
      'Wireless Headphones', 'Smart Watch', 'Running Shoes', 'Coffee Maker',
      'Laptop Stand', 'Yoga Mat', 'Water Bottle', 'Desk Lamp',
    ];

    final descriptions = [
      'High-quality product with excellent features',
      'Premium materials and craftsmanship',
      'Perfect for everyday use',
      'Durable and long-lasting design',
    ];

    return Product(
      id: 'product_$index',
      name: productNames[index % productNames.length],
      description: descriptions[index % descriptions.length],
      price: 19.99 + (_random.nextDouble() * 500),
      currency: 'USD',
      discount: index % 3 == 0 ? '${10 + _random.nextInt(40)}% OFF' : null,
      images: List.generate(
        3,
            (i) => 'https://picsum.photos/seed/product_${index}_$i/400',
      ),
      storeId: storeId ?? 'store_${index % 10}',
      categoryId: categoryId ?? 'category_${index % 8}',
      isAvailable: index % 10 != 9,
      stockQuantity: _random.nextInt(100),
    );
  }

  static List<Product> generateProducts({
    int count = 20,
    String? categoryId,
    String? storeId,
  }) {
    return List.generate(
      count,
          (i) => generateProduct(index: i, categoryId: categoryId, storeId: storeId),
    );
  }

  static PaginatedData<Product> generatePaginatedProducts({
    int page = 0,
    int pageSize = 20,
    int? totalElements,
    String? categoryId,
    String? storeId,
  }) {
    final total = totalElements ?? 100;
    final startIndex = page * pageSize;
    final products = List.generate(
      pageSize.clamp(0, total - startIndex),
          (i) => generateProduct(
        index: startIndex + i,
        categoryId: categoryId,
        storeId: storeId,
      ),
    );

    return PaginatedData<Product>(
      items: products,
      totalElements: total,
      currentPage: page,
      pageSize: pageSize,
      totalPages: (total / pageSize).ceil(),
    );
  }

  // Store Mock Data
  static Store generateStore({int index = 0}) {
    final storeNames = [
      'Tech Haven', 'Fashion Hub', 'Home Comfort', 'Sports Zone',
      'Book Nook', 'Toy World', 'Beauty Corner', 'Auto Parts Plus',
    ];

    return Store(
      id: 'store_$index',
      name: storeNames[index % storeNames.length],
      description: 'Welcome to ${storeNames[index % storeNames.length]}. We offer the best products in town!',
      coverImage: 'https://picsum.photos/seed/store_cover_$index/800/400',
      profileImage: 'https://picsum.photos/seed/store_profile_$index/200',
      sale: index % 3 == 0 ? 'Up to ${20 + _random.nextInt(50)}% OFF' : null,
      rating: 3.5 + (_random.nextDouble() * 1.5),
      address: generateAddress(index: index),
      contactInfoList: [
        ContactInfo(
          provider: 'store${index}@example.com',
          type: ContactType.email,
        ),
        ContactInfo(
          provider: '+1555${_random.nextInt(1000000).toString().padLeft(7, '0')}',
          type: ContactType.phone,
        ),
      ],
      categories: generateCategories(count: 3),
      reviews: generateReviews(count: 5, storeId: 'store_$index'),
      isActive: true,
    );
  }

  static List<Store> generateStores({int count = 10}) {
    return List.generate(count, (i) => generateStore(index: i));
  }

  // Review Mock Data
  static Review generateReview({int index = 0, required String storeId}) {
    final comments = [
      'Great store! Highly recommended.',
      'Good products but shipping was slow.',
      'Excellent customer service!',
      'Products match the description perfectly.',
      'Will definitely shop here again.',
    ];

    return Review(
      id: 'review_$index',
      storeId: storeId,
      userId: 'user_$index',
      userName: 'Customer ${index + 1}',
      userImage: 'https://i.pravatar.cc/100?img=$index',
      rating: 3.0 + (_random.nextDouble() * 2.0),
      comment: comments[index % comments.length],
      createdAt: DateTime.now().subtract(Duration(days: index * 2)),
    );
  }

  static List<Review> generateReviews({int count = 5, required String storeId}) {
    return List.generate(count, (i) => generateReview(index: i, storeId: storeId));
  }

  // Store Rating Mock Data
  static StoreRating generateStoreRating({required String storeId}) {
    return StoreRating(
      storeId: storeId,
      averageRating: 4.0 + (_random.nextDouble()),
      totalReviews: 50 + _random.nextInt(200),
      ratingDistribution: {
        5: 100 + _random.nextInt(50),
        4: 50 + _random.nextInt(30),
        3: 20 + _random.nextInt(20),
        2: 10 + _random.nextInt(10),
        1: 5 + _random.nextInt(5),
      },
    );
  }

  // Order Mock Data
  static Order generateOrder({int index = 0, OrderStatus? status}) {
    final store = generateStore(index: index % 10);

    return Order(
      id: 'order_$index',
      userId: 'user_0',
      storeId: store.id,
      storeName: store.name,
      storeImage: store.profileImage,
      items: List.generate(
        1 + _random.nextInt(3),
            (i) => generateOrderItem(index: i),
      ),
      status: status ?? OrderStatus.values[_random.nextInt(OrderStatus.values.length)],
      deliveryAddress: generateAddress(index: index),
      note: index % 2 == 0 ? 'Please deliver before 5 PM' : null,
      createdAt: DateTime.now().subtract(Duration(days: index)),
    );
  }

  static List<Order> generateOrders({int count = 10, OrderStatus? status}) {
    return List.generate(count, (i) => generateOrder(index: i, status: status));
  }

  static OrderItem generateOrderItem({int index = 0}) {
    final product = generateProduct(index: index);

    return OrderItem(
      id: 'order_item_$index',
      productId: product.id,
      productName: product.name,
      productImage: product.images.first,
      price: product.price,
      quantity: 1 + _random.nextInt(3),
    );
  }

  // Cart Mock Data
  static Cart generateCart({int itemCount = 3}) {
    return Cart(
      id: 'cart_0',
      userId: 'user_0',
      items: List.generate(itemCount, (i) => generateCartItem(index: i)),
      totalPrice: 0, // Will be calculated
    );
  }

  static CartItem generateCartItem({int index = 0}) {
    final product = generateProduct(index: index);
    final quantity = 1 + _random.nextInt(3);

    return CartItem(
      id: 'cart_item_$index',
      productId: product.id,
      productName: product.name,
      productImage: product.images.first,
      price: product.price,
      quantity: quantity,
      currency: product.currency,
    );
  }

  // Special Offer Mock Data
  static SpecialOffer generateSpecialOffer({int index = 0}) {
    final titles = [
      'Summer Sale', 'Flash Deal', 'Weekend Special', 'Clearance Sale',
      'New Arrival Discount', 'Bundle Offer', 'Limited Time Offer',
    ];

    return SpecialOffer(
      id: 'offer_$index',
      title: titles[index % titles.length],
      description: 'Get amazing discounts on selected items!',
      imageUrl: 'https://picsum.photos/seed/offer_$index/600/300',
      discount: '${10 + _random.nextInt(60)}%',
      storeId: index % 2 == 0 ? 'store_${index % 10}' : null,
      categoryId: index % 3 == 0 ? 'category_${index % 8}' : null,
      startDate: DateTime.now().subtract(Duration(days: 5)),
      endDate: DateTime.now().add(Duration(days: 10 + _random.nextInt(20))),
      isActive: true,
      createdAt: DateTime.now().subtract(Duration(days: 7)),
    );
  }

  static List<SpecialOffer> generateSpecialOffers({int count = 5}) {
    return List.generate(count, (i) => generateSpecialOffer(index: i));
  }

  // Notification Mock Data
  static Notification generateNotification({int index = 0}) {
    final now = DateTime.now();
    final time = now.subtract(Duration(hours: index));

    return Notification(
      id: 'notification_$index',
      orderId: 'order_$index',
      storeName: 'Store ${index + 1}',
      time: '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
      date: '${time.day}/${time.month}/${time.year}',
      state: index % 4,
    );
  }

  static List<Notification> generateNotifications({int count = 10}) {
    return List.generate(count, (i) => generateNotification(index: i));
  }
}