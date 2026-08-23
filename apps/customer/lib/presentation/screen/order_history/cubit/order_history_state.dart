import 'package:equatable/equatable.dart';

import '../../../../../domain/entities/order.dart';

abstract class OrderHistoryState extends Equatable {
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
  final bool hasAnyOrders;

  final bool cancelSuccess;
  final String? errorMessage;

  const OrderHistoryLoaded({
    required this.orders,
    required this.selectedTabIndex,
    required this.hasAnyOrders,
    this.cancelSuccess = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
    orders,
    selectedTabIndex,
    hasAnyOrders,
    cancelSuccess,
    errorMessage,
  ];
}
class OrderHistoryError extends OrderHistoryState {
  final String message;

  const OrderHistoryError({
    required this.message,
  });

  @override
  List<Object?> get props => [
    message,
  ];
}