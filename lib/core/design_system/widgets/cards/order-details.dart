import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

import '../../constants/assets.dart';


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
    Color bgColor;
    Color textColor;
    String statusText;

    return Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.theme.colors.surface,
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
        Row(
        children: [
        SvgPicture.asset(Assets.orderIcon, width: 20, height: 20),
        const SizedBox(width: 4),
        Text(
          "Order #${widget.orderId}",
          style: context.theme.typography.textTheme.labelMedium.copyWith(
            color: context.theme.colors.title,
          ),
        ),
  }
}