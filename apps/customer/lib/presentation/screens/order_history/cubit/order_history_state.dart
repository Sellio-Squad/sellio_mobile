import 'package:equatable/equatable.dart';
import '../../../../../domain/entities/order.dart';

sealed class OrderHistoryState extends Equatable {
  const OrderHistoryState();

  @override
  List<Object?> get props => [];
}

class OrderHistoryInitial extends OrderHistoryState {
  const OrderHistoryInitial();
}

class OrderHistoryLoading extends OrderHistoryState {
  const OrderHistoryLoading();
}

class OrderHistoryLoaded extends OrderHistoryState {
  final List<Order> orders;
  final int selectedTabIndex;
  final List<String> tabs;
  final bool hasAnyOrders;

  OrderHistoryLoaded({
    required this.orders,
    required this.selectedTabIndex,
    required this.hasAnyOrders,
    List<String>? tabs,
  }) : tabs = tabs ?? ['All Orders', 'Processing', 'Completed', 'Cancelled'];


  OrderHistoryLoaded copyWith({
    List<Order>? orders,
    int? selectedTabIndex,
    bool? hasAnyOrders,
    List<String>? tabs,
  }) {
    return OrderHistoryLoaded(
      orders: orders ?? this.orders,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      tabs: tabs ?? this.tabs,
      hasAnyOrders: hasAnyOrders ?? this.hasAnyOrders
    );
  }

  @override
  List<Object?> get props => [orders, selectedTabIndex, tabs, hasAnyOrders];
}

class OrderHistoryError extends OrderHistoryState {
  final String message;

  const OrderHistoryError({required this.message});

  @override
  List<Object?> get props => [message];
}
