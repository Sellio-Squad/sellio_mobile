import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_confirmation_response.freezed.dart';
part 'order_confirmation_response.g.dart';

@freezed
class OrderConfirmationResponse with _$OrderConfirmationResponse {
  const factory OrderConfirmationResponse({
    required String message,
    required List<String> orderIds,
  }) = _OrderConfirmationResponse;

  factory OrderConfirmationResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderConfirmationResponseFromJson(json);
}
