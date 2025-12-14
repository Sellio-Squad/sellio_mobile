import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:design_system/design_system.dart';

import '../../../../core/localization/l10n/localization_service.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  String _selectedCategory = 'Products';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          SellioChip(
            label: context.local.products,
            selected: _selectedCategory == 'Products',
            onTap: () => setState(() => _selectedCategory = 'Products'),
          ),
          const Gap(8),
          SellioChip(
            label: context.local.stores,
            selected: _selectedCategory == 'Stores',
            onTap: () => setState(() => _selectedCategory = 'Stores'),
          ),
        ],
      ),
    );
  }
}
