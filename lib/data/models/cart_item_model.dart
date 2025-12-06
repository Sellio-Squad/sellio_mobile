import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/cart.dart';

part 'cart_item_model.freezed.dart';
part 'cart_item_model.g.dart';

@freezed
class CartItemModel with _$CartItemModel {
  const CartItemModel._();

  const factory CartItemModel({
    required String productId,
    required String productName,
    required String productImage,
    required double price,
    required int quantity,
    required String currency,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  // Mapper to domain entity
  CartItem toEntity() {
    return CartItem(
      id: productId,
      productId: productId,
      productName: productName,
      productImage: productImage,
      price: price,
      quantity: quantity,
      currency: currency,
    );
  }

  // Mapper from domain entity
  factory CartItemModel.fromEntity(CartItem item) {
    return CartItemModel(
      productId: item.productId,
      productName: item.productName,
      productImage: item.productImage,
      price: item.price,
      quantity: item.quantity,
      currency: item.currency,
    );
  }
}