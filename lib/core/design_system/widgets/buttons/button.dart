import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

import '../../themes/dimentions.dart';
import 'AnimatedLoadingDots.dart';

class SellioButton extends StatelessWidget {
  const SellioButton({
    super.key,
    required this.text,
    this.textStyle,
    this.textColor,
    this.backgroundColor,
    this.loadingColors,
    this.fullWidth = true,
    this.onTap,
    this.verticalPadding = SellioDimensions.buttonVerticalPadding,
    this.horizontalPadding = SellioDimensions.buttonHorizontalPadding,
    this.borderRadius = SellioDimensions.buttonBorderRadius,
    this.isLoading = false,
    this.isEnabled = true,
    this.suffixSvgPath,
    this.suffixIconColor,
  });

  final String text;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? backgroundColor;
  final List<Color>? loadingColors;
  final bool fullWidth;
  final Function()? onTap;
  final double verticalPadding;
  final double horizontalPadding;
  final double borderRadius;
  final bool isLoading;
  final bool isEnabled;
  final String? suffixSvgPath;
  final Color? suffixIconColor;

  @override
  Widget build(BuildContext context) {
    final isInteractive = isEnabled && !isLoading;

    final finalTextColor = !isEnabled
        ? (context.theme.colors.hint)
        : (textColor ?? context.theme.colors.onPrimary);

    final finalBackgroundColor = !isEnabled
        ? (context.theme.colors.disabled)
        : (backgroundColor ?? context.theme.colors.primary);

    return GestureDetector(
      onTap: isInteractive ? onTap : null,
      child: Container(
        width: fullWidth ? double.infinity : null,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        decoration: BoxDecoration(
          color: finalBackgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: fullWidth
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Text(
              text,
              style:
                  (textStyle ?? context.theme.typography.textTheme.labelMedium)
                      .copyWith(color: finalTextColor),
            ),
            if (isLoading) ...[
              Gap(SellioDimensions.buttonIconSpacing),
              AnimatedLoadingDots(
                colors:
                    loadingColors ?? context.theme.colors.loadingLightColors,
              ),
            ] else if (suffixSvgPath != null) ...[
              Gap(SellioDimensions.buttonIconSpacing),
              SvgPicture.asset(
                suffixSvgPath!,
                width: SellioDimensions.buttonIconWidth,
                height: SellioDimensions.buttonIconHeight,
                colorFilter: ColorFilter.mode(
                  suffixIconColor ?? context.theme.colors.onPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
