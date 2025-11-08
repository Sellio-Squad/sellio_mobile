import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/categories/cubit/categories_cubit.dart';
import '../../../features/products/cubit/products_cubit.dart';
import '../../../features/stores/cubit/stores_cubit.dart';
import '../../../features/offers/cubit/offers_cubit.dart';
import '../../../features/cart/cubit/cart_cubit.dart';
import '../../../features/favorites/cubit/favorites_cubit.dart';
import '../../../features/user/cubit/user_cubit.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CategoriesCubit _categoriesCubit;
  final ProductsCubit _productsCubit;
  final StoresCubit _storesCubit;
  final OffersCubit _offersCubit;
  final CartCubit _cartCubit;
  final FavoritesCubit _favoritesCubit;
  final UserCubit _userCubit;

  HomeCubit({
    required CategoriesCubit categoriesCubit,
    required ProductsCubit productsCubit,
    required StoresCubit storesCubit,
    required OffersCubit offersCubit,
    required CartCubit cartCubit,
    required FavoritesCubit favoritesCubit,
    required UserCubit userCubit,
  })  : _categoriesCubit = categoriesCubit,
        _productsCubit = productsCubit,
        _storesCubit = storesCubit,
        _offersCubit = offersCubit,
        _cartCubit = cartCubit,
        _favoritesCubit = favoritesCubit,
        _userCubit = userCubit,
        super(const HomeInitial());

  Future<void> initializeHome() async {
    emit(const HomeLoading());

    try {
      await Future.wait([
        _userCubit.loadUserInfo(),
        _categoriesCubit.loadCategories(),
        _productsCubit.loadTrendingProducts(),
        _storesCubit.loadTopStores(),
        _offersCubit.loadSpecialOffers(),
        _cartCubit.loadCart(),
        _favoritesCubit.loadFavorites(),
      ]);

      emit(const HomeLoaded());
    } catch (e) {
      emit(HomeError(message: 'Failed to initialize home: ${e.toString()}'));
    }
  }

  Future<void> refreshHome() async {
    try {
      await Future.wait([
        _categoriesCubit.loadCategories(),
        _productsCubit.refreshProducts(),
        _storesCubit.refreshStores(),
        _offersCubit.refreshOffers(),
        _cartCubit.loadCart(),
        _favoritesCubit.loadFavorites(),
        _userCubit.refreshUserInfo(),
      ]);
    } catch (e) {
      emit(HomeError(message: 'Failed to refresh: ${e.toString()}'));
      emit(const HomeLoaded());
    }
  }

  void onCategorySelected(int index, List<dynamic> categories) {
    if (index == 0) {
      _productsCubit.loadTrendingProducts();
    } else if (index < categories.length) {
      final categoryId = categories[index].category.id;
      _productsCubit.loadProductsByCategory(categoryId);
    }
  }

  void onSearch(String query) {
    _productsCubit.searchProducts(query);
  }

  void onFilterPressed() {
    // TODO: Implement filter dialog
    // This could open a filter bottom sheet and apply filters to products
    emit(const HomeFilterRequested());
    // Revert state after action
    Future.delayed(const Duration(milliseconds: 100), () {
      if (state is HomeFilterRequested) {
        emit(const HomeLoaded());
      }
    });
  }

  void onOfferTapped(String offerId) {
    // TODO: Navigate to offer details
    emit(HomeOfferSelected(offerId: offerId));
    // Revert state after navigation
    Future.delayed(const Duration(milliseconds: 100), () {
      if (state is HomeOfferSelected) {
        emit(const HomeLoaded());
      }
    });
  }

  void onStoreTapped(String storeId) {
    emit(HomeStoreSelected(storeId: storeId));
    // Revert state after navigation
    Future.delayed(const Duration(milliseconds: 100), () {
      if (state is HomeStoreSelected) {
        emit(const HomeLoaded());
      }
    });
  }

  void onNotificationTapped() {
    // TODO: Navigate to notifications
    emit(const HomeNotificationRequested());
    // Revert state after navigation
    Future.delayed(const Duration(milliseconds: 100), () {
      if (state is HomeNotificationRequested) {
        emit(const HomeLoaded());
      }
    });
  }


  void clearError() {
    if (state is HomeError) {
      emit(const HomeLoaded());
    }
  }
}
