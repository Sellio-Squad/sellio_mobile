import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:design_system/design_system.dart';

class AccountOptionCard extends StatelessWidget {
  final Color? cardColor;
  final double borderRadius;
  final String prefixIcon;
  final double iconSize;
  final Widget? trailing;
  final String orderTitle;
  final VoidCallback onCardClicked;

  const AccountOptionCard({
    super.key,
    this.cardColor,
    this.borderRadius = 8,
    required this.prefixIcon ,
    this.trailing,
    this.iconSize = 24,
    required this.orderTitle,
    required this.onCardClicked,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardClicked,
      child: Container(
        decoration: BoxDecoration(
          color: cardColor ?? context.theme.colors.surface,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              SvgPicture.asset(
                prefixIcon,
                width: iconSize,
                height: iconSize,
              ),
              Gap(8),
              Expanded(
                child: Text(
                  orderTitle,
                  style: context.theme.typography.textTheme.labelMedium.copyWith(
                    color: context.theme.colors.title,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
