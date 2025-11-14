import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/entities/order.dart';
import '../../../../../domain/repositories/order_repository.dart';
import 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  final OrderRepository _orderRepository;

  OrderHistoryCubit(this._orderRepository)
      : super(const OrderHistoryInitial());

  Future<void> loadOrders() async {
    emit(const OrderHistoryLoading());
    final result = await _orderRepository.getOrders();

    result.fold(
      onSuccess: (orders) {
        emit(OrderHistoryLoaded(
          orders: orders,
          filteredOrders: orders,
          selectedTabIndex: 0,
        ));
      },
      onFailure: (failure) {
        emit(OrderHistoryError(message: failure.message));
      },
    );
  }

  void selectTab(int index) {
    final currentState = state;
    if (currentState is OrderHistoryLoaded) {
      final filtered = _filterOrders(currentState.orders, index);
      emit(currentState.copyWith(
        selectedTabIndex: index,
        filteredOrders: filtered,
      ));
    }
  }

  List<Order> _filterOrders(List<Order> orders, int index) {
    switch (index) {
      case 1:
        return orders.where((order) => order.status == OrderStatus.processing).toList();
      case 2:
        return orders.where((order) => order.status == OrderStatus.completed).toList();
      case 3:
        return orders.where((order) => order.status == OrderStatus.cancelled).toList();
      default:
        return orders;
    }
  }
}
