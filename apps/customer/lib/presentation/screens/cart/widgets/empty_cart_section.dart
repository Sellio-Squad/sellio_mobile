import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/design_system.dart';
import '../../../../core/localization/l10n/localization_service.dart';
import '../../../../core/navigate/navigation_extensions.dart';

class EmptyCartSection extends StatelessWidget {
  const EmptyCartSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = theme.typography.textTheme;
    final colors = theme.colors;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(),
          const Gap(12),
          Text(
            context.local.empty_cart_title,
            style: textTheme.titleMedium.copyWith(
              color: const Color(0xDE1F1F1F),
            ),
          ),
          const Gap(4),
          Text(
            context.local.empty_cart_desc,
            style: textTheme.bodySmall.copyWith(color: colors.body),
          ),
          const Gap(12),
          _buildButton(context, textTheme, colors),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(24.5),
      decoration: const BoxDecoration(
        color: Color(0xFFFEF5F9),
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(AppImages.cartEmpty),
    );
  }

  Widget _buildButton(
    BuildContext context,
    dynamic textTheme,
    dynamic colors,
  ) {
    return SellioButton(
      text: context.local.empty_cart_button,
      fullWidth: false,
      textStyle: textTheme.labelMedium.copyWith(color: colors.onPrimary),
      verticalPadding: 13,
      horizontalPadding: 24,
      onTap: () => context.navigator.goToHome(),
    );
  }
}
