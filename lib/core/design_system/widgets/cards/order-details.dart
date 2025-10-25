import 'package:flutter/material.dart';


class OrderDetails extends StatelessWidget {
  final String orderId;
  final String orderDate;
  final String status;
  final int orderTotal;
  final String marketName;
  final String marketImage;
  final VoidCallback onCancelClick;
  final VoidCallback onViewDetailsClick;

  const OrderDetails({
    super.key,
    required this.orderId,
    required this.orderDate,
    required this.status,
    required this.orderTotal,
    required this.marketName,
    required this.marketImage,
    required this.onCancelClick,
    required this.onViewDetailsClick,
  });

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}