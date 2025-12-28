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

  Future<bool> toggleProductFavorite(String productId) async {
    emit(const FavoritesLoading());

    try {
      await _favoritesRepository.toggleProductFavorite(productId);
      debugPrint('Succeded to toggle product favorite:}');
      emit(FavoritesLoaded(productIds:Set(),storeIds: Set()));

      return true;
    } catch (e) {

      debugPrint('Failed to toggle product favorite: ${e.toString()}');
      emit(FavoritesError(
        message: 'Failed to update favorite: ${e.toString()}',
        productIds: Set(),
        storeIds:Set(),
        favoriteProducts:[],
        favoriteStores:[],
        loadingProductIds: Set(),
        loadingStoreIds: Set(),
      ));
      return false;
    }
  }

  Future<bool> toggleStoreFavorite(String storeId) async {
    if (state is! FavoritesLoaded) return false;

    final currentState = state as FavoritesLoaded;
    
    // Prevent duplicate requests for the same store
    if (currentState.loadingStoreIds.contains(storeId)) {
      debugPrint('Toggle already in progress for store: $storeId');
      return false;
    }

    // Step 1: Add to loading set (show loader in UI)
    final loadingIds = Set<String>.from(currentState.loadingStoreIds)..add(storeId);
    emit(currentState.copyWith(loadingStoreIds: loadingIds));

    try {
      // Step 2: Make API call and wait for response
      await _favoritesRepository.toggleStoreFavorite(storeId);
      
      // Step 3: On success, toggle the favorite state
      final isFavorite = currentState.storeIds.contains(storeId);
      final updatedIds = Set<String>.from(currentState.storeIds);
      
      if (isFavorite) {
        updatedIds.remove(storeId);
        debugPrint('Store $storeId removed from favorites');
      } else {
        updatedIds.add(storeId);
        debugPrint('Store $storeId added to favorites');
      }

      // Remove from loading and update storeIds
      final finalLoadingIds = Set<String>.from(loadingIds)..remove(storeId);
      emit(currentState.copyWith(
        storeIds: updatedIds,
        loadingStoreIds: finalLoadingIds,
      ));

      return true;
    } catch (e) {
      // Step 4: On error, remove from loading but keep original state
      debugPrint('Failed to toggle store favorite: ${e.toString()}');
      
      final finalLoadingIds = Set<String>.from(loadingIds)..remove(storeId);
      emit(currentState.copyWith(loadingStoreIds: finalLoadingIds));
      
      // Emit error state briefly
      emit(FavoritesError(
        message: 'Failed to update favorite: ${e.toString()}',
        productIds: currentState.productIds,
        storeIds: currentState.storeIds,
        favoriteProducts: currentState.favoriteProducts,
        favoriteStores: currentState.favoriteStores,
        loadingProductIds: currentState.loadingProductIds,
        loadingStoreIds: finalLoadingIds,
      ));
      
      // Restore to loaded state
      emit(currentState.copyWith(loadingStoreIds: finalLoadingIds));
      
      return false;
    }
  }

  bool isProductFavorite(String productId) {
    return state.productIds.contains(productId);
  }

  bool isStoreFavorite(String storeId) {
    return state.storeIds.contains(storeId);
  }

  bool isProductLoading(String productId) {
    return state.loadingProductIds.contains(productId);
  }

  bool isStoreLoading(String storeId) {
    return state.loadingStoreIds.contains(storeId);
  }

  List<Product> get favoriteProductsList => state.favoriteProducts ?? [];

  List<Store> get favoriteStoresList => state.favoriteStores ?? [];
}
