import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:seller/core/localization/l10n/localization_service.dart';
import 'package:seller/domain/entities/product_filter.dart';

class ProductsFilterBottomSheet extends StatefulWidget {
  final ProductSort initialSort;
  final ValueChanged<ProductSort> onApply;

  const ProductsFilterBottomSheet({
    super.key,
    required this.initialSort,
    required this.onApply,
  });

  @override
  State<ProductsFilterBottomSheet> createState() =>
      _ProductsFilterBottomSheetState();
}

class _ProductsFilterBottomSheetState extends State<ProductsFilterBottomSheet> {
  late ProductSort _selectedSort;

  @override
  void initState() {
    super.initState();
    _selectedSort = widget.initialSort;
  }

  @override
  Widget build(BuildContext context) {
    final sortOptions = {
      ProductSort.priceHighest: context.local.sort_price_highest,
      ProductSort.priceLowest: context.local.sort_price_lowest,
      ProductSort.stockHighest: context.local.sort_stock_highest,
      ProductSort.stockLowest: context.local.sort_stock_lowest,
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.local.filter,
          style: context.theme.typography.textTheme.titleMedium.copyWith(
            color: context.theme.colors.title,
          ),
        ),
        const Gap(24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: sortOptions.entries.map((entry) {
            return SellioChip(
              label: entry.value,
              selected: _selectedSort == entry.key,
              onTap: () => setState(() => _selectedSort = entry.key),
            );
          }).toList(),
        ),
        const Gap(24),
        SellioButton(
          text: context.local.apply,
          textStyle: context.theme.typography.textTheme.labelMedium.copyWith(
            color: context.theme.colors.onPrimary,
          ),
          onTap: () {
            widget.onApply(_selectedSort);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
