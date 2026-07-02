import 'package:equatable/equatable.dart';

enum SellerOrderStatus {
  processing,
  completed,
  cancelled,
}

class SellerOrder extends Equatable {
  final String orderId;
  final DateTime orderDate;
  final SellerOrderStatus status;
  final double totalPrice;
  final String customerName;
  final List<SellerOrderItem> items;

  const SellerOrder({
    required this.orderId,
    required this.orderDate,
    required this.status,
    required this.totalPrice,
    required this.customerName,
    required this.items,
  });

  @override
  List<Object?> get props => [
        orderId,
        orderDate,
        status,
        totalPrice,
        customerName,
        items,
      ];
}

class SellerOrderItem extends Equatable {
  final String id;
  final String productName;
  final int quantity;
  final double price;

  const SellerOrderItem({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  @override
  List<Object?> get props => [id, productName, quantity, price];
}
