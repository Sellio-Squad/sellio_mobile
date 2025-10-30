import 'package:flutter/material.dart';
import '../../../../core/design_system/widgets/chip_category.dart';

class OrderHistoryTabs extends StatefulWidget {
  const OrderHistoryTabs({super.key});

  @override
  State<OrderHistoryTabs> createState() => _OrderHistoryTabsState();
}

class _OrderHistoryTabsState extends State<OrderHistoryTabs> {
  int _selectedOrderHistoryIndex = 0;

  final List<String> _orderHistories = [
    'All Orders',
    'Processing',
    'Completed',
    'Cancelled'
  ];

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _orderHistories.length,
          itemBuilder: (context, index) {
            final isSelected = _selectedOrderHistoryIndex == index;
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: ChipCategory(
                label: _orderHistories[index],
                selected: isSelected,
                onTap: () {
                  setState(() {
                    _selectedOrderHistoryIndex = index;
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