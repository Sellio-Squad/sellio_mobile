import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'cubit/order_history_cubit.dart';
import 'cubit/order_history_state.dart';

class OrderHistoryTabs extends StatelessWidget {
  const OrderHistoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
      builder: (context, state) {
        if (state is! OrderHistoryLoaded) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
        final tabs = [
          context.local.all_orders,
          context.local.processing,
          context.local.completed,
          context.local.cancelled,
        ];

        return SliverToBoxAdapter(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: List.generate(
                tabs.length,
                (index) {
                  final isSelected = state.selectedTabIndex == index;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: SellioChip(
                      label: tabs[index],
                      selected: isSelected,
                      assetIcon: null,
                      onTap: () {
                        context.read<OrderHistoryCubit>().selectTab(index);
                      },
                      padding: EdgeInsetsDirectional.only(
                          start: 10, end: 10, top: 10, bottom: 10),
                    ),
                  );
                },
              ),
            ),
            // ),
          ),
        );
      },
    );
  }
}
