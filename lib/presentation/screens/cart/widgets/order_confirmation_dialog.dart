import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/design_system/constants/app_images.dart';
import '../../../../core/design_system/themes/sellio_theme_provider.dart';
import '../../../../core/design_system/widgets/buttons/sellio_button.dart';
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
      builder: (_) => _OrderConfirmationContent(),
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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIcon(colors),
          const Gap(8),
          Text(
            context.local.order_received,
            style: textTheme.titleSmall.copyWith(color: colors.title),
          ),
          const Gap(24),
          _buildBackButton(context, theme),
        ],
      ),
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
      textStyle: context.theme.typography.textTheme.labelMedium.copyWith(
        color: context.theme.colors.primary,
      ),
       //backgroundColor: context.theme.colors.primaryVariant,
      onTap: () => context.navigator.goToHome(),
      fullWidth: true,
    );
  }
}
