import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/product.dart';
import 'item_model.dart';

part 'product_model.freezed.dart';

@freezed
class ProductModel with _$ProductModel {
  // Required for custom methods
  const ProductModel._();

  const factory ProductModel({
    required String id,
    required String title,
    required String description,
    double? minPrice,
    required String currency,
    String? maxDiscount,
    String? mainImageUrl,
    required List<String> images,
    required String storeId,
    required String categoryId,
    @Default([]) List<String> subCategoriesIds,
    @Default(true) bool isAvailable,
    @Default(0) int stockQuantity,
    required List<ItemModel> items,
    @Default(false) bool isFavorite,
    @Default(false) bool isUsed,
    @Default(false) bool isFeatured,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']?.toString() ?? '',
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      minPrice: _parseDouble(json['minPrice']),
      currency: (json['currency'] ?? '').toString(),
      maxDiscount: json['maxDiscount']?.toString(),
      mainImageUrl: json['mainImageUrl']?.toString(),
      images: _extractImages(json),
      storeId: json['storeId']?.toString() ?? json['store_id']?.toString() ?? '',
      categoryId: _extractCategoryId(json),
      subCategoriesIds: _extractSubCategories(json),
      isAvailable: json['isAvailable'] as bool? ?? json['is_available'] as bool? ?? true,
      stockQuantity: json['stockQuantity'] as int? ?? json['stock_quantity'] as int? ?? 0,
      isFavorite: json['isFavorite'] as bool? ?? false,
      isUsed: json['isUsed'] as bool? ?? false,
      isFeatured: json['isFeatured'] as bool? ?? false,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  Product toEntity() {
    final allImages = <String>[
      ...images,
      if (mainImageUrl != null && mainImageUrl!.isNotEmpty)
        mainImageUrl!,
    ].where((e) => e.isNotEmpty).toSet().toList();

    return Product(
      id: id,
      title: title,
      description: description,
      minPrice: _parseDouble(minPrice) ?? 0.0,
      currency: currency,
      maxDiscount: maxDiscount,
      images: allImages,
      storeId: storeId,
      categoryId: categoryId,
      subCategoriesIds: subCategoriesIds,
      isAvailable: isAvailable,
      stockQuantity: stockQuantity,
      items: items.map((e) => e.toEntity()).toList(),
      isFavorite: isFavorite,
      isUsed: isUsed,
      isFeatured: isFeatured,
    );
  }

  factory ProductModel.fromEntity(Product product) {
    return ProductModel(
      id: product.id,
      title: product.title,
      description: product.description,
      minPrice: product.minPrice,
      currency: product.currency,
      maxDiscount: product.maxDiscount,
      images: product.images,
      storeId: product.storeId,
      categoryId: product.categoryId,
      subCategoriesIds: product.subCategoriesIds,
      isAvailable: product.isAvailable,
      stockQuantity: product.stockQuantity,
      items: product.items.map((e) => ItemModel.fromEntity(e)).toList(),
      isFavorite: product.isFavorite,
      isUsed: product.isUsed,
      isFeatured: product.isFeatured,
    );
  }

  // --- Helper Methods (Static) ---

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static List<String> _extractSubCategories(Map<String, dynamic> json) {
    final raw = json['subCategoriesIds'] ?? json['subCategoryIds'] ?? json['sub_category_ids'];
    if (raw is! List) return [];
    return raw
        .where((e) => e != null)
        .map((e) => e.toString())
        .where((e) => e.isNotEmpty)
        .toList();
  }

  static List<String> _extractImages(Map<String, dynamic> json) {
    final images = <String>[];

    void tryAdd(dynamic value) {
      final str = value?.toString();
      if (_isValidUrl(str)) images.add(str!);
    }

    void addFromList(dynamic value) {
      if (value is List) {
        for (final item in value) {
          tryAdd(item);
        }
      }
    }

    tryAdd(json['mainImageURL'] ?? json['mainImageUrl'] ?? json['main_image_url']);

    addFromList(json['images']);
    addFromList(json['imageUrls']);
    addFromList(json['image_urls']);

    return images.toSet().toList();
  }

  static String _extractCategoryId(Map<String, dynamic> json) {
    final direct = json['categoryId'] ?? json['category_id'] ?? json['categoryID'];
    if (direct != null && direct.toString().isNotEmpty) return direct.toString();

    final subCategories = json['subCategoryIds'] ?? json['subCategoriesIds'] ?? json['sub_category_ids'];
    if (subCategories is List && subCategories.isNotEmpty) {
      return subCategories.first?.toString() ?? '';
    }

    return '';
  }

  static bool _isValidUrl(String? value) {
    if (value == null || value.trim().isEmpty) return false;
    final uri = Uri.tryParse(value.trim());
    return uri != null && (uri.isScheme('http') || uri.isScheme('https'));
  }
}