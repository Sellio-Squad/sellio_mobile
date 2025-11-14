import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/sellio_button.dart';
import 'package:sellio_mobile/core/localization/localization_service.dart';

import '../../../../domain/entities/order.dart';
import '../../constants/assets.dart';

class OrderDetailsCard extends StatefulWidget {
  final Order order;
  final VoidCallback? onCancelClick;
  final VoidCallback onViewDetailsClick;
  final VoidCallback onOrderAgainClick;

  const OrderDetailsCard({
    super.key,
    required this.order,
    this.onCancelClick,
    required this.onViewDetailsClick,
    required this.onOrderAgainClick,
  });

  @override
  State<OrderDetailsCard> createState() => _OrderDetailsCardState();
}

class _OrderDetailsCardState extends State<OrderDetailsCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final order = widget.order;

    // Determine colors and status text
    Color bgColor;
    Color textColor;
    String statusText;

    switch (order.status) {
      case OrderStatus.pending:
      case OrderStatus.processing:
        bgColor = context.theme.colors.secondaryVariant;
        textColor = context.theme.colors.secondary;
        statusText = context.local.processing;
        break;
      case OrderStatus.completed:
        bgColor = context.theme.colors.greenVariant;
        textColor = context.theme.colors.green;
        statusText = context.local.completed;
        break;
      case OrderStatus.cancelled:
        bgColor = context.theme.colors.errorVariant;
        textColor = context.theme.colors.red;
        statusText = context.local.cancelled;
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
          // Header row: order ID + status
          Row(
            children: [
              SvgPicture.asset(Assets.orderIcon, width: 20, height: 20),
              const SizedBox(width: 4),
              Text(
                "${context.local.order} #${order.id}",
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
              "${context.local.placed_on} ${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}",
              style: context.theme.typography.textTheme.labelXSmall.copyWith(
                color: context.theme.colors.body,
              ),
            ),
          ),

          const SizedBox(height: 12),
          // Expandable section
          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
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
                        context.theme.colors.body,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(order.storeImage),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.storeName,
                          style: context.theme.typography.textTheme.labelSmall
                              .copyWith(color: context.theme.colors.body),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "${order.itemCount} ${context.local.items}",
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
                children: order.items.map((item) {
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
          if (order.canBeCancelled && widget.onCancelClick != null)
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SellioButton(
                    text: context.local.view_details,
                    onTap: widget.onViewDetailsClick,
                    textStyle: context.theme.typography.textTheme.labelSmall,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: SellioButton(
                    text: context.local.cancel_order,
                    backgroundColor: context.theme.colors.errorVariant,
                    textColor: context.theme.colors.red,
                    onTap: widget.onCancelClick!,
                    // Safe to use ! here
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
                  context.local.order_again,
                  style: context.theme.typography.textTheme.labelSmall,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
