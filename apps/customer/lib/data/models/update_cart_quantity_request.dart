import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_cart_quantity_request.freezed.dart';
part 'update_cart_quantity_request.g.dart';

@freezed
abstract class UpdateCartQuantityRequest with _$UpdateCartQuantityRequest {
  const factory UpdateCartQuantityRequest({
    required int quantity,
  }) = _UpdateCartQuantityRequest;

  factory UpdateCartQuantityRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateCartQuantityRequestFromJson(json);
}