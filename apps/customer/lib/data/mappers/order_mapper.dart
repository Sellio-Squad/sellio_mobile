import '../../domain/entities/OrderConfirmation.dart';
import '../../domain/entities/order.dart';
import '../models/order_model.dart';
import '../models/response/order_confirmation_response.dart';

extension OrderModelMapper on OrderModel {
  Order toEntity() {
    return Order(
      orderId: orderId,
      orderDate: orderDate,
      status: _mapOrderStatus(status),
      totalPrice: totalPrice,
      storeName: storeName,
      storeLogoUrl: storeLogoUrl,
      items: items
          .map(
            (item) => item.toEntity(),
      )
          .toList(),
    );
  }
}

extension OrderItemModelMapper on OrderItemModel {
  OrderItem toEntity() {
    return OrderItem(
      id: id,
      productId: productId,
      productName: productName,
      productImageUrl: productImageUrl,
      quantity: quantity,
      price: price,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension OrderConfirmationResponseMapper
on OrderConfirmationResponse {
  OrderConfirmation toEntity() {
    return OrderConfirmation(
      message: message,
      orderIds: orderIds,
    );
  }
}

OrderStatus _mapOrderStatus(String value) {
  switch (value.toUpperCase()) {
    case 'PROCESSING':
      return OrderStatus.processing;

    case 'COMPLETED':
      return OrderStatus.completed;

    case 'CANCELLED':
      return OrderStatus.cancelled;

    default:
      return OrderStatus.processing;
  }
}