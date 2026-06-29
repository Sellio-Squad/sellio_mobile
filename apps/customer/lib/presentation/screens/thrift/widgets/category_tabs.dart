import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CategoryTabs extends StatelessWidget {
  final List<CategoryTabData> categories;
  final int selectedIndex;
  final Function(int index) onCategorySelected;

  const CategoryTabs({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedIndex == index;

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: SellioChip(
              label: category.name,
              selected: isSelected,
              onTap: () {
                if (!isSelected) {
                  onCategorySelected(index);
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class CategoryTabData {
  final String id;
  final String name;

  const CategoryTabData({
    required this.id,
    required this.name,
  });
}
