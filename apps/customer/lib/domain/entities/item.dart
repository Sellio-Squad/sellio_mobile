class Item {
  final String id;
  final double price;
  final int stock;
  final String discountId;
  final String colorId;
  final String sizeId;
  final String weightId;

  const Item({
    required this.id,
    required this.price,
    required this.stock,
    required this.discountId,
    required this.colorId,
    required this.sizeId,
    required this.weightId,
  });

  Item copyWith({
    String? id,
    double? price,
    int? stock,
    String? discountId,
    String? colorId,
    String? sizeId,
    String? weightId,
  }) {
    return Item(
      id: id ?? this.id,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      discountId: discountId ?? this.discountId,
      colorId: colorId ?? this.colorId,
      sizeId: sizeId ?? this.sizeId,
      weightId: weightId ?? this.weightId,
    );
  }
}
