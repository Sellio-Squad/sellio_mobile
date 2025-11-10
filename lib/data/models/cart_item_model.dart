import '../../domain/entities/cart.dart';

class CartItemModel extends CartItem {
  const CartItemModel({
    required super.id,
    required super.productId,
    required super.productName,
    required super.productImage,
    required super.price,
    required super.quantity,
    required super.currency,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as String,
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productImage: json['productImage'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      currency: json['currency'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'price': price,
      'quantity': quantity,
      'currency': currency,
    };
  }

  Map<String, dynamic> toDbMap(String cartId) {
    return {
      'id': id,
      'cartId': cartId,
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'price': price,
      'quantity': quantity,
      'currency': currency,
    };
  }

  factory CartItemModel.fromDbMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'] as String,
      productId: map['productId'] as String,
      productName: map['productName'] as String,
      productImage: map['productImage'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
      currency: map['currency'] as String,
    );
  }

  factory CartItemModel.fromEntity(CartItem item) {
    return CartItemModel(
      id: item.id,
      productId: item.productId,
      productName: item.productName,
      productImage: item.productImage,
      price: item.price,
      quantity: item.quantity,
      currency: item.currency,
    );
  }

  CartItem toEntity() {
    return CartItem(
      id: id,
      productId: productId,
      productName: productName,
      productImage: productImage,
      price: price,
      quantity: quantity,
      currency: currency,
    );
  }
}
