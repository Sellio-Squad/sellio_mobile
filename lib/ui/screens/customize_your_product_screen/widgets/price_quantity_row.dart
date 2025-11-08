import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

import '../../../../core/design_system/themes/sellio_colors.dart';

class PriceQuantityRow extends StatelessWidget {
  final double price;
  final double oldPrice;
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const PriceQuantityRow({
    super.key,
    required this.price,
    required this.oldPrice,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '\$$oldPrice',
          style: context.theme.typography.textTheme.bodyMedium.copyWith(
            decoration: TextDecoration.lineThrough,
            decorationThickness: 2,
            decorationColor: context.theme.colors.hint,
            color: context.theme.colors.hint,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '\$$price',
          style: context.theme.typography.textTheme.titleMedium.copyWith(
            color: SellioColors.light.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: context.theme.colors.primaryVariant),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove, size: 16),
                onPressed: onDecrease,
                padding: const EdgeInsets.all(8),
                constraints: const BoxConstraints(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  quantity.toString().padLeft(2, '0'),
                  style: context.theme.typography.textTheme.labelMedium,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 16),
                onPressed: onIncrease,
                padding: const EdgeInsets.all(8),
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
