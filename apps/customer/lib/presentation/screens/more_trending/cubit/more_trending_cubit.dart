import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repositories/product_repository.dart';
import 'more_trending_state.dart';

class MoreTrendingCubit extends Cubit<MoreTrendingState> {
  final ProductRepository _productRepository;
  static const int _pageSize = 20;

  MoreTrendingCubit(this._productRepository) : super(const MoreTrendingState());

  Future<void> loadTrendingProducts() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _productRepository.getTrendingProducts(
      page: 1,
      limit: _pageSize,
    );

    result.fold(
      onSuccess: (products) {
        debugPrint('✅ Loaded ${products.length} trending products');
        emit(state.copyWith(
          items: products,
          isLoading: false,
          currentPage: 1,
          hasReachedEnd: products.length < _pageSize,
        ));
      },
      onFailure: (failure) {
        debugPrint('❌ Failed to load trending products: ${failure.message}');
        emit(state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        ));
      },
    );
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || state.hasReachedEnd || state.isLoading) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.currentPage + 1;
    final result = await _productRepository.getTrendingProducts(
      page: nextPage,
      limit: _pageSize,
    );

    result.fold(
      onSuccess: (newProducts) {
        debugPrint(
            '✅ Loaded ${newProducts.length} more products (page $nextPage)');

        final allItems = [...state.items, ...newProducts];

        emit(state.copyWith(
          items: allItems,
          isLoadingMore: false,
          currentPage: nextPage,
          hasReachedEnd: newProducts.length < _pageSize,
        ));
      },
      onFailure: (failure) {
        debugPrint('❌ Failed to load more products: ${failure.message}');
        emit(state.copyWith(
          isLoadingMore: false,
          errorMessage: failure.message,
        ));
      },
    );
  }

  Future<void> refresh() async {
    await loadTrendingProducts();
  }
}
