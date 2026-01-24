class ProductSummary {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final bool isFavorite;
  final bool? discount;
  final String? discountText;

  const ProductSummary({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.isFavorite,
    required this.discount,
    required this.discountText,
  });

  ProductSummary copyWith({
    String? id,
    String? title,
    double? price,
    String? imageUrl,
    bool? isFavorite,
    bool? hasDiscount,
    String? discountText,
  }) {
    return ProductSummary(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      discount: hasDiscount ?? discount,
      discountText: discountText ?? this.discountText,
    );
  }
}
