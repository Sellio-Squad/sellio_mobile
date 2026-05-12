import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/localization/l10n/localization_service.dart';
import '../../../../core/utils/price_calculator.dart';

class CartBottomBar extends StatelessWidget {
  final double totalPrice;
  final int itemCount;
  final VoidCallback onConfirmOrder;

  const CartBottomBar({
    super.key,
    required this.totalPrice,
    required this.itemCount,
    required this.onConfirmOrder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.typography.textTheme;
    final colors = theme.colors;

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: colors.surfaceLow,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, -4),
              blurRadius: 8,
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPriceRow(context, textTheme, colors),
            const Gap(12),
            _buildConfirmButton(context, colors),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(
      BuildContext context,
      dynamic textTheme,
      dynamic colors,
      ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          AppImages.discountTag,
          width: 20,
          height: 20,
        ),
        const Gap(4),
        Expanded(
          child: Text(
            context.local.total_price,
            style: textTheme.titleSmall.copyWith(
              color: colors.title,
            ),
            softWrap: true,
            maxLines: 2,
          ),
        ),
        const Gap(8),
        Flexible(
          child: Text(
            PriceCalculator.formatPrice(totalPrice),
            style: textTheme.titleSmall.copyWith(
              color: colors.primary,
            ),
            textAlign: TextAlign.end,
            softWrap: true,
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton(BuildContext context, dynamic colors) {
    return SellioButton(
      text: '${context.local.confirm_order} ($itemCount)',
      backgroundColor: colors.primary,
      fullWidth: true,
      suffixSvgPath: AppImages.packageAdd,
      onTap: onConfirmOrder,
    );
  }
}