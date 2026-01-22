import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptySection extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final String buttonText;
  final Color color;
  final VoidCallback onTap;

  const EmptySection({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final SellioTextTheme textTheme = context.theme.typography.textTheme;
    final SellioColorScheme colors = context.theme.colors;

    return Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              padding: EdgeInsets.all(24.5),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(icon),
            ),
            const Gap(12),
            Text(
              title,
              style: textTheme.titleMedium.copyWith(
                color: Color(0xDE1F1F1F),
              ),
            ),
            const Gap(4),
            Text(
              description,
              style: textTheme.bodySmall.copyWith(
                color: colors.body,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(12),
            SellioButton(
              text: buttonText,
              fullWidth: false,
              textStyle:
              textTheme.labelMedium.copyWith(color: colors.onPrimary),
              verticalPadding: 13,
              horizontalPadding: 24,
              onTap: onTap,
            ),
          ]),
        ));
  }
}