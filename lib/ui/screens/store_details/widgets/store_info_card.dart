import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

class StoreInfoCard extends StatelessWidget {
  final String openingHours;
  final bool isOpen;

  const StoreInfoCard({
    super.key,
    required this.openingHours,
    required this.isOpen,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;
    final textTheme = theme.typography.textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceLow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Clock Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isOpen ? colors.greenVariant : colors.errorVariant,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.access_time,
              color: isOpen ? colors.green : colors.red,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),

          // Opening Hours Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isOpen ? 'Open' : 'Closed',
                  style: textTheme.labelMedium.copyWith(
                    color: isOpen ? colors.green : colors.red,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  openingHours,
                  style: textTheme.bodySmall.copyWith(
                    color: colors.body,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}