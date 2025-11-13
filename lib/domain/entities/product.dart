import 'category.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String currency;
  final String? discount;
  final List<String> images;
  final String storeId;
  final String categoryId;
  final bool isAvailable;
  final int stockQuantity;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    this.discount,
    required this.images,
    required this.storeId,
    required this.categoryId,
    this.isAvailable = true,
    this.stockQuantity = 0,
  });

  factory Product.dummy({
    String? id,
    String? name,
    String? description,
    double? price,
    String? currency,
    String? discount,
    List<String>? images,
    String? storeId,
    String? categoryId,
    bool? isAvailable,
    int? stockQuantity,
  }) {
    return Product(
      id: id ?? 'prod_001',
      name: name ?? 'Sample Product',
      description: description ??
          'This is a sample product description with all the details you need to know.',
      price: price ?? 29.99,
      currency: currency ?? 'USD',
      discount: discount ?? '10%',
      images: images ??
          [
            'assets/images/product_3.webp',
            'assets/images/product_3.webp',
            'assets/images/product_3.webp',
          ],
      storeId: storeId ?? 'store_001',
      categoryId: categoryId ?? 'cat_001',
      isAvailable: isAvailable ?? true,
      stockQuantity: stockQuantity ?? 100,
    );
  }

  static List<Product> dummyList({int count = 5}) {
    final categories = Category.dummyList(count: 4);

    return List.generate(
      count,
      (index) {
        final category = categories[index % categories.length];
        return Product.dummy(
          id: 'prod_${(index + 1).toString().padLeft(3, '0')}',
          name: 'Product ${index + 1}',
          description:
              'Description for product ${index + 1}. This is a high-quality item.',
          price: 19.99,
          images: [
            'https://tse2.mm.bing.net/th/id/OIP.zNKs8Nv4bFVOTpS58itFVAHaHa?cb=ucfimg2ucfimg=1&rs=1&pid=ImgDetMain&o=7&rm=3',
            'https://tse2.mm.bing.net/th/id/OIP.zNKs8Nv4bFVOTpS58itFVAHaHa?cb=ucfimg2ucfimg=1&rs=1&pid=ImgDetMain&o=7&rm=3',
            'https://tse2.mm.bing.net/th/id/OIP.zNKs8Nv4bFVOTpS58itFVAHaHa?cb=ucfimg2ucfimg=1&rs=1&pid=ImgDetMain&o=7&rm=3',
          ],
          discount: index % 2 == 0 ? '${(index + 1) * 5}%' : null,
          storeId: 'store_${(index % 3 + 1).toString().padLeft(3, '0')}',
          categoryId: category.id,
          stockQuantity: 50 + (index * 20),
          isAvailable: index % 5 != 4,
        );
      },
    );
  }

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? currency,
    String? discount,
    List<String>? images,
    String? storeId,
    String? categoryId,
    bool? isAvailable,
    int? stockQuantity,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      discount: discount ?? this.discount,
      images: images ?? this.images,
      storeId: storeId ?? this.storeId,
      categoryId: categoryId ?? this.categoryId,
      isAvailable: isAvailable ?? this.isAvailable,
      stockQuantity: stockQuantity ?? this.stockQuantity,
    );
  }
}
