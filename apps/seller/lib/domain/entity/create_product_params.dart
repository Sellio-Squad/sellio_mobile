import 'package:equatable/equatable.dart';

import 'product_item.dart';

class AddProduct extends Equatable {
  final String title;
  final String description;
  final String mainImagePath;
  final String storeId;
  final String categoryId;
  final double price;
  final bool isFeatured;
  final bool isAvailable;
  final List<String> subCategoryIds;
  final List<String> additionalImagePaths;
  final List<ProductItem> items;

  const AddProduct({
    required this.title,
    required this.description,
    required this.mainImagePath,
    required this.storeId,
    required this.categoryId,
    required this.price,
    required this.isFeatured,
    required this.isAvailable,
    required this.subCategoryIds,
    required this.additionalImagePaths,
    required this.items,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        mainImagePath,
        storeId,
        categoryId,
        price,
        isFeatured,
        isAvailable,
        subCategoryIds,
        additionalImagePaths,
        items,
      ];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'storeId': storeId,
      'categoryId': categoryId,
      'price': price,
      'isFeatured': isFeatured,
      'isAvailable': isAvailable,
      'subCategoryIds': subCategoryIds,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}
