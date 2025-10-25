import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

class Chip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool selected;
  final VoidCallback onTap;
  final ShapeBorder shape;

  const Chip({
    super.key,
    required this.label,
    this.icon,
    required this.selected,
    required this.onTap,
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = selected ? context.theme.colors.primary  : context.theme.colors.surfaceLow;
    final textColor = selected ? context.theme.colors.onPrimary : context.theme.colors.body;

    return Material(
      color: backgroundColor,
      shape: shape,
      child: InkWell(
        onTap: onTap,
        customBorder: shape,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 11),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: Color(0x1FFFFFFF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon??Icons.abc, size: 20, color: textColor),
                ),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: TextStyle(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
