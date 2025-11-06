
class Product  {
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