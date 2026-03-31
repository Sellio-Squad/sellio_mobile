import 'package:design_system/design_system.dart';
import '../../../../../../domain/entities/product.dart';

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

  factory ProductSummaryUIModel.fromEntity(Product product) {
    return ProductSummaryUIModel(
      id: product.id,
      imageUrl: product.images.first,
      title: product.title,
      price: product.minPrice.toString(),
      hasDiscount: product.maxDiscount != null,
      discountText: product.maxDiscount.toString(),
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
