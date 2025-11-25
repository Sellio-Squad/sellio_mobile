import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/sellio_button.dart';
import 'package:sellio_mobile/core/design_system/widgets/cards/order_details_card.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

import '../../../core/design_system/constants/app_images.dart';
import '../../../domain/entities/order.dart';
import 'cubit/order_history_cubit.dart';
import 'cubit/order_history_state.dart';
import 'order_history_tabs.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: OrderDetailsCard(
              order: order,
              onCancelClick: () {
                if (order.canBeCancelled) {}
              },
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
        Image.asset(AppImages.noOrderHistory, width: 112, height: 112),
        Text(
          context.local.no_order_history,
          style: context.theme.typography.textTheme.titleSmall.copyWith(
            color: context.theme.colors.title,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            context.local.start_exploring_favorite_items,
            style: context.theme.typography.textTheme.bodySmall.copyWith(
              color: context.theme.colors.body,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Gap(12),
        SellioButton(
          text: context.local.start_exploring,
          fullWidth: false,
          onTap: () {},
        ),
      ],
    ),
  );
}
