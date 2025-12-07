import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:design_system/design_system.dart';

import 'package:design_system/design_system.dart';

class ContactInfoItem extends StatelessWidget {
  final String icon;
  final String title;
  final String provider;
  final VoidCallback onTap;

  const ContactInfoItem({
    super.key,
    required this.icon,
    required this.title,
    required this.provider,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: colors.primaryVariant,
              borderRadius: BorderRadius.circular(20),
            ),
            height: 40,
            width: 40,
            child: Center(
              child: SvgPicture.asset(
                icon,
                width: LayoutConstants.iconSizeMedium,
                height: LayoutConstants.iconSizeMedium,
              ),
            ),
          ),
          const SizedBox(width: LayoutConstants.paddingSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.typography.textTheme.bodySmall.copyWith(
                    color: colors.body,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  provider,
                  style: theme.typography.textTheme.labelMedium.copyWith(
                    color: colors.title,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
