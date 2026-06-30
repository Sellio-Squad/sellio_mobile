import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';

import '../../../../core/localization/l10n/localization_service.dart';
import '../../../../domain/entities/seller_order.dart';

class OrdersFilterBottomSheet extends StatefulWidget {
  final SellerOrdersSort initialSort;
  final ValueChanged<SellerOrdersSort> onApply;

  const OrdersFilterBottomSheet({
    super.key,
    required this.initialSort,
    required this.onApply,
  });

  @override
  State<OrdersFilterBottomSheet> createState() =>
      _OrdersFilterBottomSheetState();
}

class _OrdersFilterBottomSheetState extends State<OrdersFilterBottomSheet> {
  late SellerOrdersSort _selectedSort;

  @override
  void initState() {
    super.initState();
    _selectedSort = widget.initialSort;
  }

  @override
  Widget build(BuildContext context) {
    final sortOptions = {
      SellerOrdersSort.newestFirst: context.local.sort_newest,
      SellerOrdersSort.oldestFirst: context.local.sort_oldest,
      SellerOrdersSort.highestTotal: context.local.sort_highest_total,
      SellerOrdersSort.lowestTotal: context.local.sort_lowest_total,
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
