import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/repository/store_repository.dart';
import 'stores_state.dart';

class StoresCubit extends Cubit<StoresState> {
  final StoreRepository _storeRepository;
  static const int _pageSize = 20;

  StoresCubit(this._storeRepository) : super(const StoresState());

  Future<void> loadStores() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _storeRepository.getStores(
      page: 1,
      limit: _pageSize,
    );

    result.fold(
      onSuccess: (stores) {
        debugPrint('Loaded ${stores.length} stores');
        emit(state.copyWith(
          stores: stores,
          isLoading: false,
          currentPage: 1,
          hasReachedEnd: stores.length < _pageSize,
        ));
      },
      onFailure: (failure) {
        debugPrint('Failed to load stores: ${failure.message}');
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
    final result = await _storeRepository.getStores(
      page: nextPage,
      limit: _pageSize,
    );

    result.fold(
      onSuccess: (newStores) {
        debugPrint('Loaded ${newStores.length} more stores (page $nextPage)');

        final allStores = [...state.stores, ...newStores];

        emit(state.copyWith(
          stores: allStores,
          isLoadingMore: false,
          currentPage: nextPage,
          hasReachedEnd: newStores.length < _pageSize,
        ));
      },
      onFailure: (failure) {
        debugPrint('Failed to load more stores: ${failure.message}');
        emit(state.copyWith(
          isLoadingMore: false,
          errorMessage: failure.message,
        ));
      },
    );
  }

  Future<void> refresh() async {
    await loadStores();
  }
}
