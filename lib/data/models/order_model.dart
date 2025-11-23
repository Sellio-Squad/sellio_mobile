import 'package:freezed_annotation/freezed_annotation.dart';
import 'address_model.dart';

import '../../domain/entities/order.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderModel with _$OrderModel {
  const factory OrderModel({
    required String id,
    required String userId,
    required String storeId,
    required String storeName,
    required String storeImage,
    required List<OrderItemModel> items,
    required OrderStatus status,
    required AddressModel deliveryAddress,
    String? note,
    required DateTime createdAt,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}

@freezed
class OrderItemModel with _$OrderItemModel {
  const factory OrderItemModel({
    required String id,
    required String productId,
    required String productName,
    required String productImage,
    required double price,
    required int quantity,
  }) = _OrderItemModel;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);
}
