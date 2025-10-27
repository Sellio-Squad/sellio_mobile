import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import '../../../../core/design_system/widgets/chip_category.dart';

class CategoryTabs extends StatefulWidget {
  const CategoryTabs({super.key});

  @override
  State<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs> {
  int _selectedCategoryIndex = 0;

  final List<String> _categories = [
    'All',
    'Electronics',
    'Fashion',
    'Home'
  ];

  final List<String> _categoryIcons = [
    Assets.allCategories,
    Assets.food,
    Assets.drinks,
    Assets.clothes
  ];


  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final isSelected = _selectedCategoryIndex == index;
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: ChipCategory(
                label: _categories[index],
                assetIcon: _categoryIcons[index],
                selected: isSelected,
                onTap: () {
                  setState(() {
                    _selectedCategoryIndex = index;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}