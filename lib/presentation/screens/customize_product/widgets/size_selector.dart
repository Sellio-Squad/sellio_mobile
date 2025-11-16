import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

import '../../../../core/design_system/themes/sellio_colors.dart';
import '../cubit/design_editor_state.dart';

class SizeSelector extends StatelessWidget {
  final List<ProductSize> sizes;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const SizeSelector({
    super.key,
    required this.sizes,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.local.size,
          style: context.theme.typography.textTheme.titleMedium.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: sizes.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () => onSelect(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? SellioColors.light.primary
                        : context.theme.colors.surface,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    sizes[index].value,
                    style: context.theme.typography.textTheme.labelMedium.copyWith(
                      color: isSelected
                          ? Colors.white
                          : context.theme.colors.body,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
