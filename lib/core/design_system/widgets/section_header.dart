import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Widget trailing;

  const SectionHeader({
    super.key,
    required this.title,
    this.onTap,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: context.theme.typography.textTheme.titleSmall.copyWith(
                  color: context.theme.colors.title,
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}
