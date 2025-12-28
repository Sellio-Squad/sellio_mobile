import '../../../../../../domain/entities/product.dart';

class TrendingProductUIModel {
  final String id;
  final String imageUrl;
  final String title;
  final String price;
  final bool hasDiscount;
  final String? discountText;
  final bool isFavorite;

  const TrendingProductUIModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.hasDiscount = false,
    this.discountText,
    required this.isFavorite,
  });

  factory TrendingProductUIModel.fromEntity(Product product) {
    return TrendingProductUIModel(
      id: product.id,
      imageUrl: product.images.isNotEmpty
          ? product.images.first
          : 'assets/images/product_3.webp',
      title: product.title,
      price: product.price.toString(),
      hasDiscount: product.discount != null,
      discountText: product.discount,
      isFavorite: product.isFavorite,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TrendingProductUIModel &&
              runtimeType == other.runtimeType &&
              id == other.id;

  @override
  int get hashCode => id.hashCode;
}
