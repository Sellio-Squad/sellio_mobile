class Cart {
  final String id;
  final List<CartItem> items;
  final double totalPrice;
  final int itemCount;

  const Cart({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.itemCount,
  });

  Cart copyWith({
    String? id,
    List<CartItem>? items,
    double? totalPrice,
    int? itemCount,
  }) {
    return Cart(
      id: id ?? this.id,
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
      itemCount: itemCount ?? this.itemCount,
    );
  }
}

class CartItem {
  final String id;
  final String productId;
  final String productTitle;
  final String productImage;
  final double unitPrice;
  final int quantity;
  final double totalPrice;

  const CartItem({
    required this.id,
    required this.productId,
    required this.productTitle,
    required this.productImage,
    required this.unitPrice,
    required this.quantity,
    required this.totalPrice,
  });

  CartItem copyWith({
    String? id,
    String? productId,
    String? productTitle,
    String? productImage,
    double? unitPrice,
    int? quantity,
    double? totalPrice,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productTitle: productTitle ?? this.productTitle,
      productImage: productImage ?? this.productImage,
      unitPrice: unitPrice ?? this.unitPrice,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}