import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import '../../../domain/entities/order.dart';
import 'cubit/order_history_cubit.dart';
import 'cubit/order_history_state.dart';
import 'order_details_card.dart';
import 'order_history_tabs.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OrderHistoryCubit>().loadOrders();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: context.theme.colors.surfaceLow,
        appBar: SellioAppBar(
          showBackButton: true,
          title: context.local.order_history,
        ),
        body: BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
          builder: (context, state) {
            if (state is OrderHistoryLoading || state is OrderHistoryInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrderHistoryError) {
              return Center(child: Text(state.message));
            } else if (state is OrderHistoryLoaded) {
              return OrderSection(
                orders: state.orders,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class OrderSection extends StatelessWidget {
  final List<Order> orders;

  const OrderSection({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const OrderHistoryTabs(),
        if (orders.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: emptyOrderHistory(context),
            ),
          )
        else
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final order = orders[index];
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: OrderDetailsCard(
                    order: order,
                    onCancelClick: () {},
                    onViewDetailsClick: () {},
                    onOrderAgainClick: () {},
                  ),
                );
              },
              childCount: orders.length,
            ),
          ),
      ],
    );
  }
}

Widget emptyOrderHistory(BuildContext context) {
  return EmptySection(
    buttonText: context.local.start_exploring,
    icon: AppImages.noOrderHistory,
    title: context.local.no_order_history,
    description: context.local.start_exploring_favorite_items,
    color: context.theme.colors.purpleVariant,
    onTap: () {},
  );
}
