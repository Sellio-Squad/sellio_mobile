import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/localization/localization_service.dart';
import '../../../../core/design_system/widgets/chip_category.dart';

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
      context.local.clothes,
      context.local.accessories_and_gifts,
      context.local.clothes,
      context.local.clothes,
      context.local.accessories_and_gifts,
      context.local.home_and_decore,
      context.local.clothes,
      context.local.accessories_and_gifts,
      context.local.home_and_decore
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
