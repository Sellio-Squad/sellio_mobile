import 'package:flutter/material.dart';


enum OrderStatus { processing, completed, cancelled }

class OrderItem {
  final String productId;
  final String productName;
  final int quantity;
  final double price;

  const OrderItem({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });
}

class OrderDetails extends StatefulWidget {
  final String orderId;
  final String orderDate;
  final OrderStatus status;
  final int orderTotal;
  final String marketName;
  final String marketImage;
  final List<OrderItem> orderItems;
  final VoidCallback onCancelClick;
  final VoidCallback onViewDetailsClick;
  final VoidCallback onOrderAgainClick;

  const OrderDetails({
    super.key,
    required this.orderId,
    required this.orderDate,
    required this.status,
    required this.orderTotal,
    required this.marketName,
    required this.marketImage,
    required this.orderItems,
    required this.onCancelClick,
    required this.onViewDetailsClick,
    required this.onOrderAgainClick,
  });

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {

  }
}