import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/repositories/favorites_repository.dart';
import '../../../../domain/entities/product.dart';
import '../../../../domain/entities/store.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository _favoritesRepository;

  FavoritesCubit(this._favoritesRepository) : super(const FavoritesInitial());

  Future<void> loadFavorites() async {
    emit(FavoritesLoading(
      productIds: state.productIds,
      storeIds: state.storeIds,
      favoriteProducts: state.favoriteProducts,
      favoriteStores: state.favoriteStores,
    ));

    try {
      final productIdsResult =
          await _favoritesRepository.getFavoriteProductIds();
      final storeIdsResult = await _favoritesRepository.getFavoriteStoreIds();

      final productsResult =
          await _favoritesRepository.getFavoriteProductsFull();
      final storesResult = await _favoritesRepository.getFavoriteStoresFull();

      debugPrint("fav IDs: ${productIdsResult.data}, ${storeIdsResult.data}");
      debugPrint(
          "fav full: ${productsResult.data?.length ?? 0} products, ${storesResult.data?.length ?? 0} stores");

      emit(FavoritesLoaded(
        productIds: productIdsResult.data.toSet(),
        storeIds: storeIdsResult.data.toSet(),
        favoriteProducts: productsResult.isSuccess
            ? (productsResult.data as List<Product>?) ?? <Product>[]
            : null,
        favoriteStores: storesResult.isSuccess
            ? (storesResult.data as List<Store>?) ?? <Store>[]
            : null,
      ));
    } catch (e) {
      emit(FavoritesError(
        message: e.toString(),
        productIds: state.productIds,
        storeIds: state.storeIds,
        favoriteProducts: state.favoriteProducts,
        favoriteStores: state.favoriteStores,
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

  List<Product> get favoriteProductsList => state.favoriteProducts ?? [];

  List<Store> get favoriteStoresList => state.favoriteStores ?? [];
}
