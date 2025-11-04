import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/button.dart';

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

class OrderModel {
  final String id;
  final String date;
  final OrderStatus status;
  final int totalItems;
  final String marketName;
  final String marketImage;
  final List<OrderItem> orderItems;

  const OrderModel({
    required this.id,
    required this.date,
    required this.status,
    required this.totalItems,
    required this.marketName,
    required this.marketImage,
    required this.orderItems,
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

    switch (widget.status) {
      case OrderStatus.processing:
        bgColor = context.theme.colors.secondaryVariant;
        textColor = context.theme.colors.secondary;
        statusText = 'Processing';
        break;
      case OrderStatus.completed:
        bgColor = context.theme.colors.greenVariant;
        textColor = context.theme.colors.green;
        statusText = 'Completed';
        break;
      case OrderStatus.cancelled:
        bgColor = context.theme.colors.errorVariant;
        textColor = context.theme.colors.red;
        statusText = 'Cancelled';
        break;
    }

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
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: bgColor,
                ),
                child: Text(
                  statusText,
                  style: context.theme.typography.textTheme.labelXSmall
                      .copyWith(color: textColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Placed on ${widget.orderDate}",
              style: context.theme.typography.textTheme.labelXSmall.copyWith(
                color: context.theme.colors.body,
              ),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: SvgPicture.asset(
                      Assets.arrowDown,
                      width: 16,
                      height: 16,
                      colorFilter: ColorFilter.mode(
                          context.theme.colors.body, BlendMode.srcIn),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage(widget.marketImage),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.marketName,
                          style: context.theme.typography.textTheme.labelSmall
                              .copyWith(color: context.theme.colors.body),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "${widget.orderTotal} items",
                          style: context.theme.typography.textTheme.labelXSmall
                              .copyWith(color: context.theme.colors.body),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              margin: const EdgeInsets.only(top: 8),
              child: Column(
                children: widget.orderItems.map((item) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(24, 5, 12, 5),
                    child: Row(
                      children: [
                        Text(
                          "${item.quantity}X",
                          style: context.theme.typography.textTheme.labelSmall
                              .copyWith(color: context.theme.colors.body),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.productName,
                            style: context.theme.typography.textTheme.labelSmall
                                .copyWith(color: context.theme.colors.body),
                          ),
                        ),
                        Text(
                          "\$${item.price.toStringAsFixed(2)}",
                          style: context.theme.typography.textTheme.labelSmall
                              .copyWith(color: context.theme.colors.primary),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
          const SizedBox(height: 16),
          if (widget.status == OrderStatus.processing)
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SellioButton(
                    text: "View details",
                    onTap: widget.onViewDetailsClick,
                    textStyle: context.theme.typography.textTheme.labelSmall,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: SellioButton(
                    text: "Cancel Order",
                    backgroundColor: context.theme.colors.errorVariant,
                    textColor: context.theme.colors.red,
                    onTap: widget.onCancelClick,
                    textStyle: context.theme.typography.textTheme.labelSmall,
                  ),
                ),
              ],
            )
          else
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.theme.colors.primary,
                  foregroundColor: context.theme.colors.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                onPressed: widget.onOrderAgainClick,
                child: Text(
                  "Order again",
                  style: context.theme.typography.textTheme.labelSmall,
                ),
              ),
            ),
        ],
      ),
    );
  }
}