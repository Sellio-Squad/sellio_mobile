import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/repositories/favorites_repository.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository _favoritesRepository;

  FavoritesCubit(this._favoritesRepository) : super(const FavoritesState());

  Future<void> loadFavorites() async {
    try {
      final productIds = await _favoritesRepository.getFavoriteProductIds();
      final storeIds = await _favoritesRepository.getFavoriteStoreIds();
      emit(FavoritesState(
        productIds: productIds.data.toSet(),
        storeIds: storeIds.data.toSet(),
      ));
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }

  Future<void> toggleProductFavorite(String productId) async {
    final currentState = state;
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
      // Rollback on error
      emit(currentState);
      rethrow;
    }
  }

  Future<void> toggleStoreFavorite(String storeId) async {
    final currentState = state;
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
      // Rollback on error
      emit(currentState);
      rethrow;
    }
  }

  bool isProductFavorite(String productId) {
    return state.productIds.contains(productId);
  }

  bool isStoreFavorite(String storeId) {
    return state.storeIds.contains(storeId);
  }
}