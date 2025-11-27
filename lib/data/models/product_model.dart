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
    final images = _extractImages(json);
    final categoryId = _extractCategoryId(json);

    return ProductModel(
      id: json['id']?.toString() ?? '',
      name: (json['name'] ?? json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      price: _parseDouble(json['price']),
      currency: (json['currency'] ?? '').toString(),
      discount: json['discount']?.toString(),
      images: images,
      storeId: json['storeId']?.toString() ?? json['store_id']?.toString() ?? '',
      categoryId: categoryId,
      isAvailable:
          json['isAvailable'] as bool? ?? json['is_available'] as bool? ?? true,
      stockQuantity:
          json['stockQuantity'] as int? ?? json['stock_quantity'] as int? ?? 0,
    );
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static List<String> _extractImages(Map<String, dynamic> json) {
    final images = <String>[];

    void addFromList(dynamic value) {
      if (value is List) {
        for (final item in value) {
          final image = item?.toString();
          if (_isValidUrl(image)) {
            images.add(image!);
          }
        }
      }
    }

    addFromList(json['images']);
    addFromList(json['imageUrls']);
    addFromList(json['image_urls']);

    final mainImage = json['mainImageURL'] ?? json['main_image_url'];
    if (_isValidUrl(mainImage?.toString())) {
      images.insert(0, mainImage.toString());
    }

    return images;
  }

  static String _extractCategoryId(Map<String, dynamic> json) {
    final direct =
        json['categoryId'] ?? json['category_id'] ?? json['categoryID'];
    if (direct != null && direct.toString().isNotEmpty) {
      return direct.toString();
    }

    final subCategories = json['subCategoryIds'] ?? json['sub_category_ids'];
    if (subCategories is List && subCategories.isNotEmpty) {
      return subCategories.first?.toString() ?? '';
    }

    return '';
  }

  static bool _isValidUrl(String? value) {
    if (value == null) return false;
    final trimmed = value.trim();
    if (trimmed.isEmpty) return false;
    final uri = Uri.tryParse(trimmed);
    if (uri == null) return false;
    if (!(uri.isScheme('http') || uri.isScheme('https'))) return false;
    return true;
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
