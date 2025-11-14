import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

import 'AnimatedLoadingDots.dart';

class SellioButton extends StatelessWidget {
  const SellioButton(
      {super.key,
      required this.text,
      this.textStyle,
      this.textColor,
      this.backgroundColor,
      this.loadingColors,
      this.fullWidth = true,
      this.onTap,
      this.verticalPadding = 9,
      this.horizontalPadding = 24,
      this.borderRadius = 8,
      this.isLoading = false,
      this.isEnabled = true,
      this.suffixSvgPath,
      this.suffixIconColor,
      this.prefixSvgPath,
      this.prefixIconColor,
      this.iconWidth = 20,
      this.iconHeight = 20,
      this.contentAlignment = MainAxisAlignment.center});

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
  final String? prefixSvgPath;
  final Color? prefixIconColor;
  final double iconWidth;
  final double iconHeight;
  final MainAxisAlignment contentAlignment;

  @override
  Widget build(BuildContext context) {
    final isInteractive = isEnabled && !isLoading;

    final finalTextColor = !isEnabled
        ? (context.theme.colors.hint)
        : (textColor ?? context.theme.colors.onPrimary);

    final finalBackgroundColor = !isEnabled
        ? (context.theme.colors.disabled)
        : (backgroundColor ?? context.theme.colors.primary);

    final finalIconColor = !isEnabled
        ? context.theme.colors.hint
        : (suffixIconColor ?? context.theme.colors.onPrimary);

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
          mainAxisAlignment: contentAlignment,
          children: [
            if (prefixSvgPath != null) ...[
              SvgPicture.asset(
                prefixSvgPath!,
                width: iconWidth,
                height: iconHeight,
                colorFilter: ColorFilter.mode(
                  prefixIconColor ?? finalIconColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Text(
                text,
                style: (textStyle ??
                        context.theme.typography.textTheme.labelMedium)
                    .copyWith(color: finalTextColor),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isLoading) ...[
              const SizedBox(width: 8),
              AnimatedLoadingDots(
                colors:
                    loadingColors ?? context.theme.colors.loadingLightColors,
              ),
            ] else if (suffixSvgPath != null) ...[
              const SizedBox(width: 8),
              SvgPicture.asset(
                suffixSvgPath!,
                width: iconWidth,
                height: iconHeight,
                colorFilter: ColorFilter.mode(finalIconColor, BlendMode.srcIn),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
