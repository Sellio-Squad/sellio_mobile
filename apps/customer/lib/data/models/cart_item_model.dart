import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item_model.freezed.dart';
part 'cart_item_model.g.dart';

@freezed
class CartItemModel with _$CartItemModel {
  const factory CartItemModel({
    required String id,
    required String productId,
    required String productTitle,
    String? productImage,
    required double unitPrice,
    required int quantity,
    required double totalPrice,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$CartItemModelFromJson(json);
}