import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/l10n/localization_service.dart';
import '../cubit/seller_orders_cubit.dart';
import '../cubit/seller_orders_state.dart';

class OrdersTabs extends StatelessWidget {
  const OrdersTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerOrdersCubit, SellerOrdersState>(
      buildWhen: (previous, current) {
        if (previous is SellerOrdersLoaded && current is SellerOrdersLoaded) {
          return previous.selectedTabIndex != current.selectedTabIndex;
        }
        return current is SellerOrdersLoaded;
      },
      builder: (context, state) {
        if (state is! SellerOrdersLoaded) {
          return const SizedBox.shrink();
        }

        final tabs = [
          context.local.all_orders,
          context.local.processing,
          context.local.completed,
          context.local.cancelled,
        ];

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: List.generate(tabs.length, (index) {
              final isSelected = state.selectedTabIndex == index;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SellioChip(
                  label: tabs[index],
                  selected: isSelected,
                  assetIcon: null,
                  onTap: () {
                    context.read<SellerOrdersCubit>().selectTab(index);
                  },
                  padding: const EdgeInsetsDirectional.only(
                    start: 10,
                    end: 10,
                    top: 10,
                    bottom: 10,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
