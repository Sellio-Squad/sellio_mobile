import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/repositories/favorites_repository.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository _favoritesRepository;

  FavoritesCubit(this._favoritesRepository) : super(const FavoritesInitial());

  Future<void> loadFavorites() async {
    emit(FavoritesLoading(
      productIds: state.productIds,
      storeIds: state.storeIds,
    ));

    try {
      final productIds = await _favoritesRepository.getFavoriteProductIds();
      final storeIds = await _favoritesRepository.getFavoriteStoreIds();

      emit(FavoritesLoaded(
        productIds: productIds.data.toSet(),
        storeIds: storeIds.data.toSet(),
      ));
    } catch (e) {
      emit(FavoritesError(
        message: e.toString(),
        productIds: state.productIds,
        storeIds: state.storeIds,
      ));
    }
  }

  Future<void> toggleProductFavorite(String productId) async {
    if (state is! FavoritesLoaded) return;

    final currentState = state as FavoritesLoaded;
    final isFavorite = currentState.productIds.contains(productId);

    final updatedIds = Set<String>.from(currentState.productIds);
    if (isFavorite) {
      updatedIds.remove(productId);
    } else {
      updatedIds.add(productId);
    }

    // Optimistic update
    emit(currentState.copyWith(productIds: updatedIds));

    try {
      await _favoritesRepository.toggleProductFavorite(productId);
    } catch (e) {
      // Revert on error
      emit(currentState);
      emit(FavoritesError(
        message: 'Failed to update product favorite: ${e.toString()}',
        productIds: currentState.productIds,
        storeIds: currentState.storeIds,
      ));

      // Restore state after showing error
      emit(currentState);
    }
  }

  Future<void> toggleStoreFavorite(String storeId) async {
    if (state is! FavoritesLoaded) return;

    final currentState = state as FavoritesLoaded;
    final isFavorite = currentState.storeIds.contains(storeId);

    final updatedIds = Set<String>.from(currentState.storeIds);
    if (isFavorite) {
      updatedIds.remove(storeId);
    } else {
      updatedIds.add(storeId);
    }

    // Optimistic update
    emit(currentState.copyWith(storeIds: updatedIds));

    try {
      await _favoritesRepository.toggleStoreFavorite(storeId);
    } catch (e) {
      // Revert on error
      emit(currentState);
      emit(FavoritesError(
        message: 'Failed to update store favorite: ${e.toString()}',
        productIds: currentState.productIds,
        storeIds: currentState.storeIds,
      ));

      // Restore state after showing error
      emit(currentState);
    }
  }

  bool isProductFavorite(String productId) {
    return state.productIds.contains(productId);
  }

  bool isStoreFavorite(String storeId) {
    return state.storeIds.contains(storeId);
  }
}
