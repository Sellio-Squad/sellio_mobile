import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/design_system/constants/app_images.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/sellio_button.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/core/navigate/navigation_extensions.dart';
import '../../../../core/design_system/themes/sellio_colors.dart';
import '../../../../core/design_system/themes/sellio_typography.dart';

class EmptyCartSection extends StatelessWidget {
  const EmptyCartSection({
    super.key,
    required this.textTheme,
    required this.colors,
  });

  final SellioTextTheme textTheme;
  final SellioColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          padding: EdgeInsets.all(24.5),
          decoration: BoxDecoration(
            color: Color(0xFFFEF5F9),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(AppImages.cartEmpty),
        ),
        const Gap(12),
        Text(
          context.local.empty_cart_title,
          style: textTheme.titleMedium.copyWith(
            color: Color(0xDE1F1F1F),
          ),
        ),
        const Gap(4),
        Text(
          context.local.empty_cart_desc,
          style: textTheme.bodySmall.copyWith(
            color: colors.body,
          ),
        ),
        const Gap(12),
        SellioButton(
          text: context.local.empty_cart_button,
          fullWidth: false,
          textStyle: textTheme.labelMedium.copyWith(color: colors.onPrimary),
          verticalPadding: 13,
          horizontalPadding: 24,
          onTap: () => context.navigator.goToHome(),
        ),
      ]),
    );
  }
}