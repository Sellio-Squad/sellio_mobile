import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sellio_mobile/core/design_system/constants/app_strings.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/button.dart';
import 'package:sellio_mobile/core/design_system/widgets/cards/order_details.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import '../../../domain/entities/order.dart';
import 'OrderHistoryCubit.dart';
import 'order_history_state.dart';
import 'order_history_tabs.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: SellioAppBar(
            showBackButton: true,
            title: AppStrings.orderHistory,
          ),
          body: BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
            builder: (context, state) {
              if (state is OrderHistoryLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is OrderHistoryError) {
                return Center(child: Text(state.message));
              } else if (state is OrderHistoryLoaded) {
                final orders = state.filteredOrders;
                return CustomScrollView(
                  slivers: [
                    const OrderHistoryTabs(),
                    OrderSection(orders: orders),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
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
    if (orders.isEmpty) {
      return SliverToBoxAdapter(child: emptyOrderHistory(context));
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          final order = orders[index];
          return Padding(
            padding: const EdgeInsets.all(16),
            child: OrderDetails(
              order: order,
              onCancelClick: order.canBeCancelled ? () {} : () {},
              onViewDetailsClick: () {},
              onOrderAgainClick: () {},
            ),
          );
        },
        childCount: orders.length,
      ),
    );
  }
}
Widget emptyOrderHistory(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.6,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Assets.noOrderHistory, width: 112, height: 112),
        Text(
          'No order history!',
          style: context.theme.typography.textTheme.titleSmall.copyWith(
            color: context.theme.colors.title,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Start exploring and purchasing your favorite items',
            style: context.theme.typography.textTheme.bodySmall.copyWith(
              color: context.theme.colors.body,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Gap(12),
        SellioButton(text: 'Start Exploring', fullWidth: false, onTap: () {}),
      ],
    ),
  );
}