import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/design_system/constants/app_images.dart';
import '../../../../core/design_system/themes/sellio_theme_provider.dart';
import '../../../../core/design_system/widgets/buttons/sellio_button.dart';
import '../../../../core/localization/l10n/localization_service.dart';
import '../../../../core/utils/price_calculator.dart';
import '../constants/cart_constants.dart';

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

    return Container(
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
      height: CartConstants.bottomBarHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: CartConstants.horizontalPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPriceRow(context, textTheme, colors),
          const Gap(12),
          _buildConfirmButton(context, colors),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
      BuildContext context,
      dynamic textTheme,
      dynamic colors,
      ) {
    return Row(
      children: [
        SvgPicture.asset(AppImages.discountTag),
        const Gap(4),
        Text(
          context.local.total_price,
          style: textTheme.titleSmall.copyWith(color: colors.title),
        ),
        const Spacer(),
        Text(
          PriceCalculator.formatPrice(totalPrice),
          style: textTheme.titleSmall.copyWith(color: colors.primary),
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