import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_cart_item_request.freezed.dart';
part 'add_cart_item_request.g.dart';

@freezed
class AddCartItemRequest with _$AddCartItemRequest {
  const factory AddCartItemRequest({
    required String productId,
    required int quantity,
  }) = _AddCartItemRequest;

  factory AddCartItemRequest.fromJson(Map<String, dynamic> json) =>
      _$AddCartItemRequestFromJson(json);
}