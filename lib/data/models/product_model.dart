import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.currency,
    super.discount,
    required super.images,
    required super.storeId,
    required super.categoryId,
    super.isAvailable,
    super.stockQuantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: _parseDouble(json['price']),
      currency: json['currency'] as String? ?? '',
      discount: json['discount'] as String?,
      images: _parseImages(json['images']),
      storeId: json['storeId'] as String? ?? json['store_id'] as String? ?? '',
      categoryId: json['categoryId'] as String? ?? json['category_id'] as String? ?? '',
      isAvailable: json['isAvailable'] as bool? ?? json['is_available'] as bool? ?? true,
      stockQuantity: json['stockQuantity'] as int? ?? json['stock_quantity'] as int? ?? 0,
    );
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static List<String> _parseImages(dynamic value) {
    if (value == null) return [];
    if (value is List) {
      return value
          .where((e) => e != null)
          .map((e) => e.toString())
          .toList();
    }
    return [];
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'currency': currency,
      'discount': discount,
      'images': images,
      'storeId': storeId,
      'categoryId': categoryId,
      'isAvailable': isAvailable,
      'stockQuantity': stockQuantity,
    };
  }

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      currency: product.currency,
      discount: product.discount,
      images: product.images,
      storeId: product.storeId,
      categoryId: product.categoryId,
      isAvailable: product.isAvailable,
      stockQuantity: product.stockQuantity,
    );
  }

  Product toEntity() {
    return Product(
      id: id,
      name: name,
      description: description,
      price: price,
      currency: currency,
      discount: discount,
      images: images,
      storeId: storeId,
      categoryId: categoryId,
      isAvailable: isAvailable,
      stockQuantity: stockQuantity,
    );
  }
}
