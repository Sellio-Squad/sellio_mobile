import 'package:equatable/equatable.dart';

import '../../../../domain/entities/category.dart';
import '../../../../domain/entities/product_item.dart';
import '../../../../domain/entities/subcategory.dart';

sealed class CreateProductState extends Equatable {
  const CreateProductState();

  @override
  List<Object?> get props => [];
}

class CreateProductInitial extends CreateProductState {
  const CreateProductInitial();
}

class CreateProductFormState extends CreateProductState {
  final String title;
  final String description;
  final String? mainImagePath;
  final List<String> additionalImagePaths;
  final double price;
  final int stockQuantity;
  final bool isFeatured;
  final bool isAvailable;

  final List<Category> categories;
  final String categoryId;

  final List<Subcategory> subcategories;
  final List<String> subCategoryIds;

  final List<Map<String, String>> colors;
  final String colorId;

  final List<Map<String, String>> sizes;
  final String sizeId;

  final int weightId;

  final List<Map<String, String>> discounts;
  final String discountId;

  final List<ProductItem> items;
  final bool isSubmitting;
  final String? error;
  final bool isSuccess;
  final bool isLoadingMetadata;

  const CreateProductFormState({
    this.title = '',
    this.description = '',
    this.mainImagePath,
    this.additionalImagePaths = const [],
    this.price = 0.0,
    this.stockQuantity = 0,
    this.isFeatured = false,
    this.isAvailable = true,
    this.categories = const [],
    this.categoryId = '',
    this.subcategories = const [],
    this.subCategoryIds = const [],
    this.colors = const [],
    this.colorId = '',
    this.sizes = const [],
    this.sizeId = '',
    this.weightId = 0,
    this.discounts = const [],
    this.discountId = '',
    this.items = const [],
    this.isSubmitting = false,
    this.error,
    this.isSuccess = false,
    this.isLoadingMetadata = false,
  });

  CreateProductFormState copyWith({
    String? title,
    String? description,
    String? mainImagePath,
    List<String>? additionalImagePaths,
    double? price,
    int? stockQuantity,
    bool? isFeatured,
    bool? isAvailable,
    List<Category>? categories,
    String? categoryId,
    List<Subcategory>? subcategories,
    List<String>? subCategoryIds,
    List<Map<String, String>>? colors,
    String? colorId,
    List<Map<String, String>>? sizes,
    String? sizeId,
    int? weightId,
    List<Map<String, String>>? discounts,
    String? discountId,
    List<ProductItem>? items,
    bool? isSubmitting,
    String? error,
    bool? isSuccess,
    bool? isLoadingMetadata,
  }) {
    return CreateProductFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      mainImagePath: mainImagePath ?? this.mainImagePath,
      additionalImagePaths: additionalImagePaths ?? this.additionalImagePaths,
      price: price ?? this.price,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      isFeatured: isFeatured ?? this.isFeatured,
      isAvailable: isAvailable ?? this.isAvailable,
      categories: categories ?? this.categories,
      categoryId: categoryId ?? this.categoryId,
      subcategories: subcategories ?? this.subcategories,
      subCategoryIds: subCategoryIds ?? this.subCategoryIds,
      colors: colors ?? this.colors,
      colorId: colorId ?? this.colorId,
      sizes: sizes ?? this.sizes,
      sizeId: sizeId ?? this.sizeId,
      weightId: weightId ?? this.weightId,
      discounts: discounts ?? this.discounts,
      discountId: discountId ?? this.discountId,
      items: items ?? this.items,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoadingMetadata: isLoadingMetadata ?? this.isLoadingMetadata,
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        mainImagePath,
        additionalImagePaths,
        price,
        stockQuantity,
        isFeatured,
        isAvailable,
        categories,
        categoryId,
        subcategories,
        subCategoryIds,
        colors,
        colorId,
        sizes,
        sizeId,
        weightId,
        discounts,
        discountId,
        items,
        isSubmitting,
        error,
        isSuccess,
        isLoadingMetadata,
      ];
}
