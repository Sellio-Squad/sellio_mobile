import 'dart:convert';
import '../../domain/entities/cart.dart';
import 'cart_item_model.dart';

class CartModel {
  final List<CartItemModel> items;

  const CartModel({required this.items});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      items: (json['items'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((e) => e.toJson()).toList(),
    };
  }

  Cart toEntity() {
    final totalPrice = items.fold(
      0.0,
          (sum, item) => sum + (item.price * item.quantity),
    );

    return Cart(
      id: '',
      userId: '',
      items: items.map((e) => e.toEntity()).toList(),
      totalPrice: totalPrice,
    );
  }

  String toJsonString() => jsonEncode(toJson());

  factory CartModel.fromJsonString(String jsonString) {
    return CartModel.fromJson(jsonDecode(jsonString));
  }
}