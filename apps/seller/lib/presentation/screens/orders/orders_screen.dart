import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/l10n/localization_service.dart';
import '../../../di/injection_container.dart';
import 'cubit/seller_orders_cubit.dart';
import 'cubit/seller_orders_state.dart';
import 'widgets/orders_body.dart';
import 'widgets/orders_empty_state.dart';
import 'widgets/orders_error_state.dart';
import 'widgets/orders_loading_state.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SellerOrdersCubit>()..loadOrders(),
      child: Scaffold(
        backgroundColor: context.theme.colors.surfaceLow,
        appBar: SellioAppBar(
          title: context.local.orders,
        ),
        body: BlocBuilder<SellerOrdersCubit, SellerOrdersState>(
          buildWhen: (previous, current) {
            if (previous.runtimeType != current.runtimeType) {
              return true;
            }
            if (previous is SellerOrdersLoaded && current is SellerOrdersLoaded) {
              return previous.hasAnyOrders != current.hasAnyOrders;
            }
            return false;
          },
          builder: (context, state) {
            return switch (state) {
              SellerOrdersInitial() => const OrdersLoadingState(),
              SellerOrdersLoading() => const OrdersLoadingState(),
              SellerOrdersLoaded(:final hasAnyOrders) =>
                hasAnyOrders ? const OrdersBody() : OrdersEmptyState(
                    isFiltered: false,
                    onRefresh: () =>
                        context.read<SellerOrdersCubit>().refreshOrders(),
                  ),
              SellerOrdersError(:final message) => OrdersErrorState(
                  message: message,
                  onRetry: () => context.read<SellerOrdersCubit>().loadOrders(),
                ),
            };
          },
        ),
      ),
    );
  }
}
