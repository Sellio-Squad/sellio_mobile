import 'package:freezed_annotation/freezed_annotation.dart';

import 'cart_item_model.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

@freezed
class CartModel with _$CartModel {
  const factory CartModel({
    required String id,
    required List<CartItemModel> items,
    required double totalPrice,
    required int itemCount,
  }) = _CartModel;

  factory CartModel.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$CartModelFromJson(json);
}