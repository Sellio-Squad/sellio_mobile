import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/seller_orders_cubit.dart';
import '../cubit/seller_orders_state.dart';
import 'orders_empty_state.dart';
import 'orders_loading_state.dart';
import 'seller_order_card.dart';

class OrdersListSection extends StatelessWidget {
  const OrdersListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerOrdersCubit, SellerOrdersState>(
      buildWhen: (previous, current) {
        if (previous is SellerOrdersLoaded && current is SellerOrdersLoaded) {
          return previous.orders != current.orders ||
              previous.isListLoading != current.isListLoading ||
              previous.isFiltered != current.isFiltered;
        }
        return previous.runtimeType != current.runtimeType;
      },
      builder: (context, state) {
        if (state is! SellerOrdersLoaded) {
          return const SizedBox.shrink();
        }

        if (state.isListLoading) {
          return const OrdersLoadingState();
        }

        if (state.orders.isEmpty) {
          return OrdersEmptyState(
            isFiltered: state.isFiltered,
            onRefresh: () => context.read<SellerOrdersCubit>().refreshOrders(),
          );
        }

        return RefreshIndicator(
          onRefresh: () => context.read<SellerOrdersCubit>().refreshOrders(),
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            itemCount: state.orders.length,
            itemBuilder: (context, index) {
              final order = state.orders[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SellerOrderCard(
                  order: order,
                  onViewDetails: () {},
                ),
              );
            },
          ),
        );
      },
    );
  }
}
