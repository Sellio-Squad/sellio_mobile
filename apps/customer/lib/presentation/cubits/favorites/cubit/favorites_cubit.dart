import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/presentation/cubits/auth/authentication_cubit.dart';
import '../../../../domain/entities/product.dart';
import '../../../../domain/entities/store.dart';
import '../../../../domain/repositories/favorites_repository.dart';
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

  // Load favorites initially
  Future<void> _loadInitialFavorites() async {
    await refreshFavorites();
  }

  // <-- NEW: Public method to refresh favorites from backend
  Future<void> refreshFavorites() async {
    try {
      emit(const FavoritesInitial());

      final productsResult =
          await _favoritesRepository.getFavoriteProductsFull();
      final storesResult = await _favoritesRepository.getFavoriteStoresFull();

      final products =
          productsResult.isSuccess ? productsResult.data : <Product>[];
      final stores = storesResult.isSuccess ? storesResult.data : <Store>[];

      emit(
        FavoritesLoaded(
          favoriteProducts: products,
          favoriteStores: stores,
          favoriteProductIds: products.map((e) => e.id).toSet(),
          favoriteStoreIds: stores.map((e) => e.id).toSet(),
        ),
      );
    } catch (_) {
      emit(const FavoritesActionFailure('Failed to load favorites'));
    }
  }

  Future<bool> toggleFavorite(String id, FavoriteType type) async {
    return await _authenticationCubit.requireLogin(() async {
      if (state is! FavoritesLoaded) return false;

      final current = state as FavoritesLoaded;

      if (type == FavoriteType.product) {
        final updatedIds = Set<String>.from(current.favoriteProductIds);

        if (updatedIds.contains(id)) {
          updatedIds.remove(id);
        } else {
          updatedIds.add(id);
        }

        emit(current.copyWith(
          favoriteProductIds: updatedIds,
        ));

        try {
          await _favoritesRepository.toggleProductFavorite(id);

          return true;
        } catch (_) {
          emit(current);

          return false;
        }
      } else if (type == FavoriteType.store) {
        final updatedIds = Set<String>.from(current.favoriteStoreIds);

        if (updatedIds.contains(id)) {
          updatedIds.remove(id);
        } else {
          updatedIds.add(id);
        }

        emit(current.copyWith(
          favoriteStoreIds: updatedIds,
        ));

        try {
          await _favoritesRepository.toggleStoreFavorite(id);

          return true;
        } catch (_) {
          emit(current);

          return false;
        }
      }
    }) ?? false;
  }
}
