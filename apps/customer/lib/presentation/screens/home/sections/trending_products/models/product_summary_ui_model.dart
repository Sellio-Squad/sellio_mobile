import 'package:design_system/design_system.dart';
import '../../../../../../domain/entities/product.dart';
import '../../../../../../domain/entities/product_summary.dart';

class ProductSummaryUIModel {
  final String id;
  final String imageUrl;
  final String title;
  final String price;
  final bool hasDiscount;
  final String? discountText;
  final bool isFavorite;

  const ProductSummaryUIModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.hasDiscount = false,
    this.discountText,
    required this.isFavorite,
  });

  factory ProductSummaryUIModel.fromEntity(ProductSummary product) {
    return ProductSummaryUIModel(
      id: product.id,
      imageUrl: product.imageUrl.isNotEmpty
          ? product.imageUrl
          : AppImages.cartProduct,
      title: product.title,
      price: product.price.toString(),
      hasDiscount: product.discount != null, // The getter 'discount' isn't defined for the type 'ProductSummary'.
      discountText: product.discount.toString(), // The getter 'discount' isn't defined for the type 'ProductSummary'.
      isFavorite: product.isFavorite,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ProductSummaryUIModel &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}
