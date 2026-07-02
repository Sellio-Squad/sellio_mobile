import 'package:design_system/constants/app_images.dart';
import 'package:design_system/themes/sellio_theme_provider.dart';
import 'package:design_system/widgets/buttons/sellio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/localization/l10n/localization_service.dart';
import '../../../../domain/entities/seller_order.dart';
import '../../../utils/date_format.dart';

class SellerOrderCard extends StatefulWidget {
  final SellerOrder order;
  final VoidCallback onViewDetails;

  const SellerOrderCard({
    super.key,
    required this.order,
    required this.onViewDetails,
  });

  @override
  State<SellerOrderCard> createState() => _SellerOrderCardState();
}

class _SellerOrderCardState extends State<SellerOrderCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final order = widget.order;

    late final Color bgColor;
    late final Color textColor;
    late final String statusText;

    switch (order.status) {
      case SellerOrderStatus.processing:
        bgColor = context.theme.colors.secondaryVariant;
        textColor = context.theme.colors.secondary;
        statusText = context.local.processing;
      case SellerOrderStatus.completed:
        bgColor = context.theme.colors.greenVariant;
        textColor = context.theme.colors.green;
        statusText = context.local.completed;
      case SellerOrderStatus.cancelled:
        bgColor = context.theme.colors.errorVariant;
        textColor = context.theme.colors.red;
        statusText = context.local.cancelled;
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
              SvgPicture.asset(AppImages.orderIcon, width: 20, height: 20),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  '${context.local.order} #${order.orderId}',
                  style:
                      context.theme.typography.textTheme.labelMedium.copyWith(
                    color: context.theme.colors.title,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
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
              '${context.local.placed_on} ${formatDateToReadable(order.orderDate)}',
              style: context.theme.typography.textTheme.labelXSmall.copyWith(
                color: context.theme.colors.body,
              ),
            ),
          ),
          const SizedBox(height: 12),
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
                      AppImages.arrowDown,
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
                    backgroundColor: context.theme.colors.secondaryVariant,
                    child: SvgPicture.asset(
                      AppImages.user,
                      width: 18,
                      height: 18,
                      colorFilter: ColorFilter.mode(
                        context.theme.colors.secondary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.customerName,
                          style: context.theme.typography.textTheme.labelSmall
                              .copyWith(color: context.theme.colors.body),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${order.items.length} ${context.local.items}',
                          style: context.theme.typography.textTheme.labelXSmall
                              .copyWith(color: context.theme.colors.body),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '\$${order.totalPrice.toStringAsFixed(2)}',
                    style: context.theme.typography.textTheme.labelSmall
                        .copyWith(color: context.theme.colors.primary),
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
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(24, 5, 12, 5),
                    child: Row(
                      children: [
                        Text(
                          '${item.quantity}X',
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
                          '\$${item.price.toStringAsFixed(2)}',
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
          SellioButton(
            text: context.local.view_details,
            onTap: widget.onViewDetails,
            textStyle: context.theme.typography.textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
