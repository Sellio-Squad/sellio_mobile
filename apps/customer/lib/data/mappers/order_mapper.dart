import '../../domain/entities/order.dart';
import '../models/order_model.dart';

extension OrderModelMapper on OrderModel {
  Order toEntity() {
    return Order(
      orderId: orderId,
      orderDate: orderDate,
      status: _mapStatus(status),
      totalPrice: totalPrice,
      storeName: storeName,
      storeLogoUrl: storeLogoUrl,
      items: items.map((e) => e.toEntity()).toList(),
    );
  }
}

extension OrderItemModelMapper on OrderItemModel {
  OrderItem toEntity() => OrderItem(
      id: id,
      productId: productId,
      productName: productName,
      quantity: quantity,
      createdAt: createdAt,
      updatedAt: updatedAt,
      price: price);
}

OrderStatus _mapStatus(String value) {
  switch (value) {
    case 'IN_PROGRESS':
      return OrderStatus.processing;
    case 'COMPLETED':
      return OrderStatus.completed;
    case 'CANCELLED':
      return OrderStatus.cancelled;
    default:
      return OrderStatus.processing;
  }
}
