import 'package:equatable/equatable.dart';

enum OrderStatus {
  processing,
  completed,
  cancelled;
}

class Order extends Equatable {
  final String orderId;
  final DateTime orderDate;
  final OrderStatus status;
  final double totalPrice;
  final String storeName;
  final String? storeLogoUrl;
  final List<OrderItem> items;

  const Order({
    required this.orderId,
    required this.orderDate,
    required this.status,
    required this.totalPrice,
    required this.storeName,
    this.storeLogoUrl,
    required this.items,
  });

  @override
  List<Object?> get props => [
    orderId,
    orderDate,
    status,
    totalPrice,
    storeName,
    storeLogoUrl,
    items,
  ];
}

class OrderItem extends Equatable {
  final String id;
  final String productId;
  final String productName;
  final int quantity;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;

  const OrderItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props =>
      [id, productId, productName, quantity, price, createdAt, updatedAt];
}
