import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_order_response.freezed.dart';
part 'create_order_response.g.dart';

@freezed
class CreateOrderResponse with _$CreateOrderResponse {
  const factory CreateOrderResponse({
    required String message,
    required List<String> orderIds,
  }) = _CreateOrderResponse;

  factory CreateOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderResponseFromJson(json);
}
