import '../../domain/entities/cart.dart';
import 'cart_item_model.dart';

class CartModel extends Cart {
  const CartModel({
    required super.id,
    required super.userId,
    required super.items,
    required super.totalPrice,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((e) => (e as CartItemModel).toJson()).toList(),
      'totalPrice': totalPrice,
    };
  }

  factory CartModel.fromEntity(Cart cart) {
    return CartModel(
      id: cart.id,
      userId: cart.userId,
      items: cart.items,
      totalPrice: cart.totalPrice,
    );
  }

  Cart toEntity() {
    return Cart(
      id: id,
      userId: userId,
      items: items,
      totalPrice: totalPrice,
    );
  }
}
