import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/presentation/cubits/auth/authentication_cubit.dart';

import '../../../../../domain/repositories/favorites_repository.dart';
import '../../../../domain/entities/product.dart';
import '../../../../domain/entities/store.dart';
import 'favorites_state.dart';

enum FavoriteType { product, store }

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepository _favoritesRepository;
  final AuthenticationCubit _authenticationCubit;

  FavoritesCubit(
      this._favoritesRepository,
      this._authenticationCubit,
      ) : super(const FavoritesInitial()) {
    _loadInitialFavorites();
  }

  Future<void> _loadInitialFavorites() async {
    try {
      emit(const FavoritesInitial());

      final productsResult = await _favoritesRepository.getFavoriteProductsFull();
      final storesResult = await _favoritesRepository.getFavoriteStoresFull();

      final products = productsResult.isSuccess ? productsResult.data : <Product>[];
      final stores = storesResult.isSuccess ? storesResult.data : <Store>[];

      emit(FavoritesLoaded(
        favoriteProducts: products,
        favoriteStores: stores,
        favoriteProductIds: products.map((e) => e.id).toSet(),
        favoriteStoreIds: stores.map((e) => e.id).toSet(),
      ));
    } catch (_) {
      emit(const FavoritesActionFailure('Failed to load favorites'));
    }
  }

  Future<void> toggleFavorite(String id, FavoriteType type) async {
    await _authenticationCubit.requireLogin(() async {
      if (state is! FavoritesLoaded) return;

      final current = state as FavoritesLoaded;

      if (type == FavoriteType.product) {
        final isFavorite = current.favoriteProductIds.contains(id);

        final updatedProducts = isFavorite
            ? current.favoriteProducts.where((p) => p.id != id).toList()
            : current.favoriteProducts;

        emit(current.copyWith(
          favoriteProducts: updatedProducts,
          favoriteProductIds: updatedProducts.map((e) => e.id).toSet(),
        ));

        try {
          await _favoritesRepository.toggleProductFavorite(id);
        } catch (_) {
          emit(current);
        }
      } else if (type == FavoriteType.store) {
        final isFavorite = current.favoriteStoreIds.contains(id);

        final updatedStores = isFavorite
            ? current.favoriteStores.where((s) => s.id != id).toList()
            : current.favoriteStores;

        emit(current.copyWith(
          favoriteStores: updatedStores,
          favoriteStoreIds: updatedStores.map((e) => e.id).toSet(),
        ));

        try {
          await _favoritesRepository.toggleStoreFavorite(id);
        } catch (_) {
          emit(current);
        }
      }
    });
  }

}
