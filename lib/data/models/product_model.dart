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
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      discount: json['discount'] as String?,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      storeId: json['storeId'] as String,
      categoryId: json['categoryId'] as String,
      isAvailable: json['isAvailable'] as bool? ?? true,
      stockQuantity: json['stockQuantity'] as int? ?? 0,
    );
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
