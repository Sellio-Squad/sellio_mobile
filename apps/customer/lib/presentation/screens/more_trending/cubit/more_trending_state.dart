import 'package:equatable/equatable.dart';
import '../../../../domain/entities/product.dart';

class MoreTrendingState extends Equatable {
  final List<Product> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasReachedEnd;
  final int currentPage;
  final String? errorMessage;

  const MoreTrendingState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasReachedEnd = false,
    this.currentPage = 1,
    this.errorMessage,
  });

  MoreTrendingState copyWith({
    List<Product>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasReachedEnd,
    int? currentPage,
    String? errorMessage,
  }) {
    return MoreTrendingState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        items,
        isLoading,
        isLoadingMore,
        hasReachedEnd,
        currentPage,
        errorMessage,
      ];
}
