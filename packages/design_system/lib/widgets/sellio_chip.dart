import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../themes/sellio_theme_provider.dart';

class SellioChip extends StatelessWidget {
  final String label;
  final String? assetIcon;
  final bool selected;
  final VoidCallback onTap;
  final ShapeBorder shape;
  final EdgeInsetsDirectional padding;

  const SellioChip({
    super.key,
    required this.label,
    this.assetIcon,
    required this.selected,
    required this.onTap,
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(100)),
    ),
    this.padding = const EdgeInsetsDirectional.only(start: 4, end: 8),
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = selected
        ? context.theme.colors.primary
        : context.theme.colors.surface;
    final contentColor = selected
        ? context.theme.colors.onPrimary
        : context.theme.colors.body;
    final containerColor = selected
        ? Color(0x1FFFFFFF)
        : context.theme.colors.surfaceLow;

    return Material(
      color: backgroundColor,
      shape: shape,
      child: InkWell(
        onTap: onTap,
        enableFeedback: true,
        customBorder: shape,
        child: Container(
          padding: padding,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 4,
              right: 4,
              top: 4,
              bottom: 4,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (assetIcon != null) ...[
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: containerColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        assetIcon!,
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          contentColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  label,
                  style: context.theme.typography.textTheme.labelSmall.copyWith(
                    color: contentColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
