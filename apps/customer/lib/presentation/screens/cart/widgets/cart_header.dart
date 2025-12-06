import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import '../../../../core/localization/l10n/localization_service.dart';

class CartHeader extends StatelessWidget {
  final int itemCount;
  final VoidCallback? onSelectTap;

  const CartHeader({
    super.key,
    required this.itemCount,
    this.onSelectTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.typography.textTheme;
    final colors = theme.colors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$itemCount ${context.local.items}',
          style: textTheme.labelMedium.copyWith(color: colors.body),
        ),
        GestureDetector(
          onTap: onSelectTap,
          child: Text(
            context.local.select,
            style: textTheme.labelMedium.copyWith(color: colors.primary),
          ),
        ),
      ],
    );
  }
}
