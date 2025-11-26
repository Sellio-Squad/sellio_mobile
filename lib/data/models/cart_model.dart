import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/cart.dart';
import 'cart_item_model.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

@freezed
class CartModel with _$CartModel {
  const CartModel._();

  const factory CartModel({
    required List<CartItemModel> items,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  // Mapper to domain entity
  Cart toEntity() {
    final totalPrice = items.fold(
      0.0,
          (sum, item) => sum + (item.price * item.quantity),
    );

    return Cart(
      id: '',
      userId: '',
      items: items.map((item) => item.toEntity()).toList(),
      totalPrice: totalPrice,
    );
  }

  // Mapper from domain entity
  factory CartModel.fromEntity(Cart cart) {
    return CartModel(
      items: cart.items
          .map((item) => CartItemModel.fromEntity(item))
          .toList(),
    );
  }
}