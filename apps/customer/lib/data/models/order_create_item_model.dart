import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_create_item_model.freezed.dart';
part 'order_create_item_model.g.dart';

@freezed
class OrderCreateItemModel with _$OrderCreateItemModel {
  const factory OrderCreateItemModel({
    required String productItemId,
    required int quantity,
  }) = _OrderCreateItemModel;

  factory OrderCreateItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderCreateItemModelFromJson(json);
}
