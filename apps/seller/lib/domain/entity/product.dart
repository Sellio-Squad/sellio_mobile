class Product {
  final String id;
  final String title;
  final String description;
  final double minPrice;
  final String currency;
  final List<String> images;
  final String storeId;
  final String categoryId;
  final bool isAvailable;
  final bool isFeatured;
  final bool isUsed;
  final int stockQuantity;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.minPrice,
    required this.currency,
    required this.images,
    required this.storeId,
    required this.categoryId,
    this.isAvailable = true,
    this.stockQuantity = 0,
    required this.isUsed,
    required this.isFeatured,
  });

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? minPrice,
    String? currency,
    List<String>? images,
    String? storeId,
    String? categoryId,
    bool? isAvailable,
    bool? isFeatured,
    bool? isUsed,
    int? stockQuantity,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      minPrice: minPrice ?? this.minPrice,
      currency: currency ?? this.currency,
      images: images ?? this.images,
      storeId: storeId ?? this.storeId,
      categoryId: categoryId ?? this.categoryId,
      isAvailable: isAvailable ?? this.isAvailable,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      isUsed: isUsed ?? this.isUsed,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }
}
