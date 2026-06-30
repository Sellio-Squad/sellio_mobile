import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/l10n/localization_service.dart';
import '../../../../domain/entities/seller_order.dart';
import '../cubit/seller_orders_cubit.dart';
import '../cubit/seller_orders_state.dart';
import 'orders_filter_bottom_sheet.dart';
import 'orders_list_section.dart';
import 'orders_tabs.dart';

class OrdersBody extends StatefulWidget {
  const OrdersBody({super.key});

  @override
  State<OrdersBody> createState() => _OrdersBodyState();
}

class _OrdersBodyState extends State<OrdersBody> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    context.read<SellerOrdersCubit>().search(_searchController.text);
  }

  void _showFilterBottomSheet() {
    final cubit = context.read<SellerOrdersCubit>();
    final state = cubit.state;
    final initialSort = state is SellerOrdersLoaded
        ? state.sort
        : SellerOrdersSort.newestFirst;

    SellioBottomSheet.show(
      context: context,
      child: OrdersFilterBottomSheet(
        initialSort: initialSort,
        onApply: cubit.applySort,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: SellioSearchBar(
            controller: _searchController,
            hintText: context.local.search_orders,
            isShowFilterIcon: true,
            onFilterIconClicked: _showFilterBottomSheet,
            onTextSubmitted: context.read<SellerOrdersCubit>().search,
          ),
        ),
        const OrdersTabs(),
        const Expanded(child: OrdersListSection()),
      ],
    );
  }
}
