import 'package:equatable/equatable.dart';

import '../../../../domain/entities/seller_order.dart';

sealed class SellerOrdersState extends Equatable {
  const SellerOrdersState();

  @override
  List<Object?> get props => [];
}

class SellerOrdersInitial extends SellerOrdersState {
  const SellerOrdersInitial();
}

class SellerOrdersLoading extends SellerOrdersState {
  const SellerOrdersLoading();
}

class SellerOrdersLoaded extends SellerOrdersState {
  final List<SellerOrder> orders;
  final int selectedTabIndex;
  final bool hasAnyOrders;
  final String searchQuery;
  final SellerOrdersSort sort;
  final bool isListLoading;

  const SellerOrdersLoaded({
    required this.orders,
    required this.selectedTabIndex,
    required this.hasAnyOrders,
    this.searchQuery = '',
    this.sort = SellerOrdersSort.newestFirst,
    this.isListLoading = false,
  });

  bool get isFiltered =>
      searchQuery.isNotEmpty ||
      selectedTabIndex != 0 ||
      sort != SellerOrdersSort.newestFirst;

  SellerOrdersLoaded copyWith({
    List<SellerOrder>? orders,
    int? selectedTabIndex,
    bool? hasAnyOrders,
    String? searchQuery,
    SellerOrdersSort? sort,
    bool? isListLoading,
  }) {
    return SellerOrdersLoaded(
      orders: orders ?? this.orders,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      hasAnyOrders: hasAnyOrders ?? this.hasAnyOrders,
      searchQuery: searchQuery ?? this.searchQuery,
      sort: sort ?? this.sort,
      isListLoading: isListLoading ?? this.isListLoading,
    );
  }

  @override
  List<Object?> get props => [
        orders,
        selectedTabIndex,
        hasAnyOrders,
        searchQuery,
        sort,
        isListLoading,
      ];
}

class SellerOrdersError extends SellerOrdersState {
  final String message;

  const SellerOrdersError({required this.message});

  @override
  List<Object?> get props => [message];
}
