import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/seller_order.dart';
import '../../../../domain/entities/seller_orders_filter.dart';
import '../../../../domain/repositories/seller_order_repository.dart';
import 'seller_orders_state.dart';

class SellerOrdersCubit extends Cubit<SellerOrdersState> {
  final SellerOrderRepository _repository;

  final List<SellerOrderStatus?> tabs = [
    null,
    SellerOrderStatus.processing,
    SellerOrderStatus.completed,
    SellerOrderStatus.cancelled,
  ];

  List<SellerOrder> _allOrders = [];
  int _selectedTabIndex = 0;
  String _searchQuery = '';
  SellerOrdersSort _sort = SellerOrdersSort.newestFirst;

  SellerOrdersCubit(this._repository) : super(const SellerOrdersInitial());

  Future<void> loadOrders() async {
    emit(const SellerOrdersLoading());

    final result = await _repository.getOrders();

    result.fold(
      onSuccess: (orders) {
        _allOrders = orders;
        emit(
          SellerOrdersLoaded(
            orders: _applyFilters(),
            selectedTabIndex: _selectedTabIndex,
            hasAnyOrders: orders.isNotEmpty,
            searchQuery: _searchQuery,
            sort: _sort,
          ),
        );
      },
      onFailure: (failure) {
        emit(SellerOrdersError(message: failure.message));
      },
    );
  }

  Future<void> refreshOrders() async {
    final currentState = state;
    if (currentState is! SellerOrdersLoaded) {
      return loadOrders();
    }

    emit(currentState.copyWith(isListLoading: true));

    final result = await _repository.getOrders();

    result.fold(
      onSuccess: (orders) {
        _allOrders = orders;
        emit(
          SellerOrdersLoaded(
            orders: _applyFilters(),
            selectedTabIndex: _selectedTabIndex,
            hasAnyOrders: orders.isNotEmpty,
            searchQuery: _searchQuery,
            sort: _sort,
          ),
        );
      },
      onFailure: (failure) {
        emit(SellerOrdersError(message: failure.message));
      },
    );
  }

  void selectTab(int index) {
    _selectedTabIndex = index;
    _emitFilteredOrders();
  }

  void search(String query) {
    _searchQuery = query.trim();
    _emitFilteredOrders();
  }

  void applySort(SellerOrdersSort sort) {
    _sort = sort;
    _emitFilteredOrders();
  }

  void _emitFilteredOrders() {
    final currentState = state;
    if (currentState is! SellerOrdersLoaded) {
      return;
    }

    emit(
      currentState.copyWith(
        orders: _applyFilters(),
        selectedTabIndex: _selectedTabIndex,
        searchQuery: _searchQuery,
        sort: _sort,
      ),
    );
  }

  List<SellerOrder> _applyFilters() {
    var filtered = List<SellerOrder>.from(_allOrders);

    final status = tabs[_selectedTabIndex];
    if (status != null) {
      filtered = filtered.where((order) => order.status == status).toList();
    }

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered.where((order) {
        final matchesOrderId = order.orderId.toLowerCase().contains(query);
        final matchesCustomer =
            order.customerName.toLowerCase().contains(query);
        final matchesProduct = order.items.any(
          (item) => item.productName.toLowerCase().contains(query),
        );

        return matchesOrderId || matchesCustomer || matchesProduct;
      }).toList();
    }

    filtered.sort((a, b) {
      switch (_sort) {
        case SellerOrdersSort.newestFirst:
          return b.orderDate.compareTo(a.orderDate);
        case SellerOrdersSort.oldestFirst:
          return a.orderDate.compareTo(b.orderDate);
        case SellerOrdersSort.highestTotal:
          return b.totalPrice.compareTo(a.totalPrice);
        case SellerOrdersSort.lowestTotal:
          return a.totalPrice.compareTo(b.totalPrice);
      }
    });

    return filtered;
  }
}
