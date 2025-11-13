import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/widgets/chip_category.dart';
import '../../../../domain/entities/category.dart';

class StoreCategoryTabs extends StatelessWidget {
  final List<Category> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;

  const StoreCategoryTabs({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ChipCategory(
              label: categories[index].name, // Use name here
              selected: isSelected,
              onTap: () => onCategorySelected(index),
            ),
          );
        },
      ),
    );
  }
}
