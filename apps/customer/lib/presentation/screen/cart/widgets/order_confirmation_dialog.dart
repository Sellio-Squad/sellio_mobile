import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/localization/l10n/localization_service.dart';
import '../../../../core/navigate/navigation_extensions.dart';
import '../constants/cart_constants.dart';

class OrderConfirmationDialog {
  static Future<void> show(
      BuildContext context, {
        required List<String> orderIds,
      }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            CartConstants.bottomSheetRadius,
          ),
        ),
      ),
      builder: (_) => _OrderConfirmationContent(
        orderIds: orderIds,
      ),
    );
  }
}

class _OrderConfirmationContent extends StatelessWidget {
  final List<String> orderIds;

  const _OrderConfirmationContent({
    required this.orderIds,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.typography.textTheme;
    final colors = theme.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildBottomSheetDesign(colors),
          _buildIcon(colors),
          const Gap(24),

          _buildOrderNumber(
            context,
            colors,
            textTheme,
          ),

          const Gap(8),

          _buildOrderReceived(
            context,
            colors,
            textTheme,
          ),

          const Gap(24),

          _buildBackButton(
            context,
            theme,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheetDesign(
      dynamic colors,
      ) {
    return Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.only(
        bottom: 24,
      ),
      decoration: BoxDecoration(
        color: colors.stroke,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildOrderNumber(
      BuildContext context,
      dynamic colors,
      dynamic textTheme,
      ) {
    if (orderIds.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: double.infinity,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
              context.local.order_number(
                orderIds.first,
              ),
              maxLines: 1,
              softWrap: false,
              style: textTheme.labelMedium.copyWith(
                color: colors.title,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildOrderReceived(
      BuildContext context,
      dynamic colors,
      dynamic textTheme,
      ) {
    return Text(
      context.local.order_received,
      textAlign: TextAlign.center,
      style: textTheme.titleSmall.copyWith(
        color: colors.title,
      ),
      maxLines: 2,
    );
  }

  Widget _buildIcon(
      dynamic colors,
      ) {
    return Container(
      padding: const EdgeInsets.all(
        CartConstants.confirmationIconPadding,
      ),
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

  Widget _buildBackButton(
      BuildContext context,
      dynamic theme,
      ) {
    return SellioButton(
      text: context.local.back_to_shopping,
      textColor: context.theme.colors.primary,
      backgroundColor:
      context.theme.colors.primaryVariant,
      onTap: () {
        context.navigator.pop();
        context.navigator.goToHome();
      },
      fullWidth: true,
    );
  }
}