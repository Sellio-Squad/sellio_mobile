import 'package:flutter/material.dart';
import '../../../core/design_system/widgets/chip_category.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      "Clothes",
      "Accessories & Gifts",
      "Home & Decore",
      "Clothes",
      "Accessories & Gifts",
      "Home & Decore",
      "Clothes",
      "Accessories & Gifts",
      "Home & Decore",
    ];

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (BuildContext context, int index) {
            final isSelected = _selectedCategoryIndex == index;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChipCategory(
                label: categories[index],
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
