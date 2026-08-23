import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/order.dart';
import '../../../../../domain/repository/order_repository.dart';
import 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  final OrderRepository _orderRepository;

  OrderHistoryCubit(this._orderRepository)
      : super(const OrderHistoryInitial());

  final List<OrderStatus?> tabs = const [
    null,
    OrderStatus.processing,
    OrderStatus.completed,
    OrderStatus.cancelled,
  ];

  bool _hasAnyOrders = false;

  Future<void> loadOrders({
    OrderStatus? status,
    int page = 0,
    int pageSize = 10,
  }) async {
    emit(const OrderHistoryLoading());

    final result = await _orderRepository.getOrderHistory(
      status: status,
      page: page,
      pageSize: pageSize,
      sort: const [
        'createdAt,DESC',
      ],
    );

    result.fold(
      onSuccess: (orders) {
        if (status == null) {
          _hasAnyOrders = orders.isNotEmpty;
        }

        emit(
          OrderHistoryLoaded(
            orders: orders,
            selectedTabIndex: tabs.indexOf(status),
            hasAnyOrders: _hasAnyOrders,
          ),
        );
      },
      onFailure: (failure) {
        emit(
          OrderHistoryError(
            message: failure.message,
          ),
        );
      },
    );
  }

  Future<void> cancelOrder(String orderId) async {
    final currentState = state;

    if (currentState is! OrderHistoryLoaded) {
      return;
    }

    final selectedIndex = currentState.selectedTabIndex;

    final currentStatus =
    selectedIndex >= 0 && selectedIndex < tabs.length
        ? tabs[selectedIndex]
        : null;

    final result = await _orderRepository.cancelOrder(
      orderId: orderId,
    );

    await result.fold(
      onSuccess: (_) async {
        final ordersResult =
        await _orderRepository.getOrderHistory(
          status: currentStatus,
          page: 0,
          pageSize: 10,
          sort: const [
            'createdAt,DESC',
          ],
        );

        ordersResult.fold(
          onSuccess: (orders) {
            if (currentStatus == null) {
              _hasAnyOrders = orders.isNotEmpty;
            }

            emit(
              OrderHistoryLoaded(
                orders: orders,
                selectedTabIndex: selectedIndex,
                hasAnyOrders: _hasAnyOrders,
                cancelSuccess: true,
              ),
            );
          },
          onFailure: (failure) {
            emit(
              OrderHistoryLoaded(
                orders: currentState.orders,
                selectedTabIndex:
                currentState.selectedTabIndex,
                hasAnyOrders:
                currentState.hasAnyOrders,
                errorMessage: failure.message,
              ),
            );
          },
        );
      },
      onFailure: (failure) async {
        emit(
          OrderHistoryLoaded(
            orders: currentState.orders,
            selectedTabIndex:
            currentState.selectedTabIndex,
            hasAnyOrders:
            currentState.hasAnyOrders,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }

  Future<void> selectTab(int index) async {
    if (index < 0 || index >= tabs.length) {
      return;
    }

    await loadOrders(
      status: tabs[index],
    );
  }

  Future<void> refresh() async {
    final currentState = state;

    if (currentState is OrderHistoryLoaded) {
      final selectedIndex =
          currentState.selectedTabIndex;

      if (selectedIndex >= 0 &&
          selectedIndex < tabs.length) {
        await loadOrders(
          status: tabs[selectedIndex],
        );
        return;
      }
    }

    await loadOrders();
  }
}