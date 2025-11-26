import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_request_model.freezed.dart';
part 'order_request_model.g.dart';

@freezed
class OrderRequestModel with _$OrderRequestModel {
  const factory OrderRequestModel({
    required List<OrderItemModel> items,
    String? note,
  }) = _OrderRequestModel;

  factory OrderRequestModel.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestModelFromJson(json);
}

@freezed
class OrderItemModel with _$OrderItemModel {
  const factory OrderItemModel({
    required String productId,
    required int quantity,
  }) = _OrderItemModel;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);
}