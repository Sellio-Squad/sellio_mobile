import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';

class SellioRecentSearches extends StatelessWidget {
  final List<String> recentSearches;
  final String title;
  final String clearAllText;
  final VoidCallback onClearAllTap;
  final ValueChanged<String> onChipTap;

  const SellioRecentSearches({
    super.key,
    required this.recentSearches,
    required this.title,
    required this.clearAllText,
    required this.onClearAllTap,
    required this.onChipTap,
  });

  @override
  Widget build(BuildContext context) {
    if (recentSearches.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: context.theme.typography.textTheme.titleSmall.copyWith(
                  color: context.theme.colors.title,
                ),
              ),
              GestureDetector(
                onTap: onClearAllTap,
                child: Text(
                  clearAllText,
                  style: context.theme.typography.textTheme.labelMedium.copyWith(
                    color: context.theme.colors.primary,
                  ),
                ),
              ),
            ],
          ),
          const Gap(12),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: recentSearches.map((text) {
              return SellioChip(
                label: text,
                selected: false,
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 16,
                  vertical: 11,
                ),
                onTap: () => onChipTap(text),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
