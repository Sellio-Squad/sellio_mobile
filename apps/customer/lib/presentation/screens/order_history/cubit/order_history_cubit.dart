import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/entities/order.dart';
import '../../../../../domain/repositories/order_repository.dart';
import 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  final OrderRepository _orderRepository;

  final List<OrderStatus?> tabs = [null, OrderStatus.pending, OrderStatus.processing, OrderStatus.completed, OrderStatus.cancelled];

  OrderHistoryCubit(this._orderRepository) : super(const OrderHistoryInitial());

  Future<void> loadOrders({OrderStatus? status, int page = 1, int limit = 20}) async {
    emit(const OrderHistoryLoading());

    final result = await _orderRepository.getOrders(
      status: status,
      page: page,
      limit: limit,
    );

    result.fold(
      onSuccess: (orders) {
        emit(OrderHistoryLoaded(
          orders: orders,
          selectedTabIndex: tabs.indexOf(status),
        ));
      },
      onFailure: (failure) {
        emit(OrderHistoryError(message: failure.message));
      },
    );
  }

  void selectTab(int index) {
    final status = tabs[index];
    loadOrders(status: status);
  }
}
