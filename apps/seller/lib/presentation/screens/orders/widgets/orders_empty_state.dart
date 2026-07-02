import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/localization/l10n/localization_service.dart';

class OrdersEmptyState extends StatelessWidget {
  final bool isFiltered;
  final VoidCallback onRefresh;

  const OrdersEmptyState({
    super.key,
    required this.isFiltered,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (isFiltered) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24.5),
                decoration: BoxDecoration(
                  color: context.theme.colors.purpleVariant,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(AppImages.noOrderHistory),
              ),
              const SizedBox(height: 12),
              Text(
                context.local.no_orders_found,
                style: context.theme.typography.textTheme.titleMedium.copyWith(
                  color: context.theme.colors.title,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                context.local.no_orders_found_description,
                style: context.theme.typography.textTheme.bodySmall.copyWith(
                  color: context.theme.colors.body,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return EmptySection(
      icon: AppImages.noOrderHistory,
      title: context.local.no_orders_yet,
      description: context.local.no_orders_description,
      buttonText: context.local.refresh_orders,
      color: context.theme.colors.purpleVariant,
      onTap: onRefresh,
    );
  }
}
