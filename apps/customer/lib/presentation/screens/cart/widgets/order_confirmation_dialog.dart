import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:design_system/design_system.dart';
import '../../../../core/localization/l10n/localization_service.dart';
import '../../../../core/navigate/navigation_extensions.dart';
import '../constants/cart_constants.dart';

class OrderConfirmationDialog {
  static Future<void> show(
    BuildContext context,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(CartConstants.bottomSheetRadius),
        ),
      ),
      builder: (_) => const _OrderConfirmationContent(),
    );
  }
}

class _OrderConfirmationContent extends StatelessWidget {
  const _OrderConfirmationContent();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.typography.textTheme;
    final colors = theme.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildBottomSheetDeign(colors),
          _buildIcon(colors),
          const Gap(24),
          _buildOrderNumber(colors, textTheme),
          const Gap(8),
          _buildOrderReceived(context, colors, textTheme),
          const Gap(24),
          _buildBackButton(context, theme),
        ],
      ),
    );
  }

  Widget _buildBottomSheetDeign(dynamic colors) {
    return Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: colors.stroke,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildOrderNumber(dynamic colors, dynamic textTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppImages.product,
          width: 18,
          height: 18,
          colorFilter: ColorFilter.mode(
            colors.title,
            BlendMode.srcIn,
          ),
        ),
        const Gap(8),
        Text(
          "Order #2002124",
          style: textTheme.labelMedium.copyWith(
            color: colors.title,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderReceived(BuildContext context, colors, textTheme) {
    return Text(
      context.local.order_received,
      textAlign: TextAlign.center,
      style: textTheme.titleSmall.copyWith(
        color: colors.title,
      ),
      maxLines: 2,
    );
  }

  Widget _buildIcon(dynamic colors) {
    return Container(
      padding: const EdgeInsets.all(CartConstants.confirmationIconPadding),
      width: CartConstants.confirmationIconSize,
      height: CartConstants.confirmationIconSize,
      decoration: BoxDecoration(
        color: colors.primaryVariant,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        AppImages.cartPackageDelivered,
        colorFilter: ColorFilter.mode(
          colors.primary,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context, dynamic theme) {
    return SellioButton(
      text: context.local.back_to_shopping,
      textColor: context.theme.colors.primary,
      backgroundColor: context.theme.colors.primaryVariant,
      onTap: () {
        context.navigator.pop();
        context.navigator.goToHome();
      },
      fullWidth: true,
    );
  }
}
