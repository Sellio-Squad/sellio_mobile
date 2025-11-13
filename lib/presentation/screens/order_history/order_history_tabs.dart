import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/design_system/widgets/chip_category.dart';
import 'OrderHistoryCubit.dart';
import 'order_history_state.dart';

class OrderHistoryTabs extends StatelessWidget {
  const OrderHistoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
      builder: (context, state) {
        if (state is! OrderHistoryLoaded) return const SizedBox.shrink();

        return SliverToBoxAdapter(
          child: SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: state.tabs.length,
              itemBuilder: (context, index) {
                final isSelected = state.selectedTabIndex == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ChipCategory(
                    label: state.tabs[index],
                    selected: isSelected,
                    onTap: () {
                      context.read<OrderHistoryCubit>().selectTab(index);
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
