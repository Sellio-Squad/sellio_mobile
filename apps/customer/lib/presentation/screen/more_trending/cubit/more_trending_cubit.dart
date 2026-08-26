import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repository/product_repository.dart';
import '../../../../domain/repository/search_repository.dart';
import 'more_trending_state.dart';

class MoreTrendingCubit extends Cubit<MoreTrendingState> {
  final ProductRepository _productRepository;
  final SearchRepository _searchRepository;
  static const int _pageSize = 20;

  MoreTrendingCubit(
    this._productRepository,
    this._searchRepository,
  ) : super(const MoreTrendingState());

  Future<void> loadTrendingProducts() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _productRepository.getTrendingProducts(
      page: 1,
      limit: _pageSize,
    );

    result.fold(
      onSuccess: (products) {
        debugPrint('✅ Loaded ${products.length} trending products');
        emit(
          state.copyWith(
            items: products,
            isLoading: false,
            currentPage: 1,
            hasReachedEnd: products.length < _pageSize,
            searchQuery: null,
          ),
        );
      },
      onFailure: (failure) {
        debugPrint(
          '❌ Failed to load trending products: ${failure.message}',
        );
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }

  Future<void> searchProducts(String query) async {
    if (query.trim().isEmpty) {
      await loadTrendingProducts();
      return;
    }

    if (query.trim().length < 2) {
      return;
    }

    emit(
      state.copyWith(
        isLoading: true,
        searchQuery: query,
        errorMessage: null,
      ),
    );

    final result = await _searchRepository.searchProducts(
      query: query.trim(),
      page: 1,
      limit: _pageSize,
    );

    result.fold(
      onSuccess: (products) {
        emit(
          state.copyWith(
            items: products,
            isLoading: false,
            currentPage: 1,
            hasReachedEnd: products.length < _pageSize,
            searchQuery: query,
          ),
        );
      },
      onFailure: (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || state.hasReachedEnd || state.isLoading) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.currentPage + 1;

    final result = state.searchQuery != null &&
            state.searchQuery!.trim().isNotEmpty
        ? await _searchRepository.searchProducts(
            query: state.searchQuery!.trim(),
            page: nextPage,
            limit: _pageSize,
          )
        : await _productRepository.getTrendingProducts(
            page: nextPage,
            limit: _pageSize,
          );

    result.fold(
      onSuccess: (newProducts) {
        debugPrint(
          '✅ Loaded ${newProducts.length} more products (page $nextPage)',
        );

        final allItems = [...state.items, ...newProducts];

        emit(
          state.copyWith(
            items: allItems,
            isLoadingMore: false,
            currentPage: nextPage,
            hasReachedEnd: newProducts.length < _pageSize,
          ),
        );
      },
      onFailure: (failure) {
        debugPrint('❌ Failed to load more products: ${failure.message}');
        emit(
          state.copyWith(
            isLoadingMore: false,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }

  Future<void> refresh() async {
    if (state.searchQuery != null && state.searchQuery!.trim().isNotEmpty) {
      await searchProducts(state.searchQuery!);
    } else {
      await loadTrendingProducts();
    }
  }
}
