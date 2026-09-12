import 'package:equatable/equatable.dart';

import '../../../../domain/entities/store.dart';

class StoresState extends Equatable {
  final List<Store> stores;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasReachedEnd;
  final int currentPage;
  final String? errorMessage;

  const StoresState({
    this.stores = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasReachedEnd = false,
    this.currentPage = 1,
    this.errorMessage,
  });

  StoresState copyWith({
    List<Store>? stores,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasReachedEnd,
    int? currentPage,
    String? errorMessage,
  }) {
    return StoresState(
      stores: stores ?? this.stores,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        stores,
        isLoading,
        isLoadingMore,
        hasReachedEnd,
        currentPage,
        errorMessage,
      ];
}
