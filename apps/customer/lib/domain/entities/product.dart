import 'item.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String currency;
  final String? discount;
  final List<String> images;
  final List<Item> items;
  final String storeId;
  final String categoryId;
  final bool isAvailable;
  final bool isFavorite;
  final bool isFeatured;
  final bool isUsed;
  final int stockQuantity;

  const Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.currency,
      this.discount,
      required this.images,
      required this.storeId,
      required this.categoryId,
      this.isAvailable = true,
      this.stockQuantity = 0,
      required this.items,
      required this.isFavorite,
      required bool this.isUsed,
      required bool this.isFeatured});

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? currency,
    String? discount,
    List<String>? images,
    String? storeId,
    String? categoryId,
    bool? isAvailable,
    bool? isFavorite,
    bool? isFeatured,
    bool? isUsed,
    int? stockQuantity,
    List<Item>? items,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      discount: discount ?? this.discount,
      images: images ?? this.images,
      storeId: storeId ?? this.storeId,
      categoryId: categoryId ?? this.categoryId,
      isAvailable: isAvailable ?? this.isAvailable,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      items: items ?? this.items,
      isFavorite: isFavorite ?? this.isFavorite,
      isUsed: isUsed ?? this.isUsed,
      isFeatured: isFeatured ?? this.isFeatured
    );
  }
}
