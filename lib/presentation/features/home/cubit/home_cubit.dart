import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/design_system/constants/assets.dart';
import '../../../../domain/repositories/category_repository.dart';
import '../../../../domain/repositories/product_repository.dart';
import '../../../../domain/repositories/store_repository.dart';
import 'home_mock_data.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CategoryRepository? _categoryRepository;
  final ProductRepository? _productRepository;
  final StoreRepository? _storeRepository;

  HomeCubit({
    CategoryRepository? categoryRepository,
    ProductRepository? productRepository,
    StoreRepository? storeRepository,
  })  : _categoryRepository = categoryRepository,
        _productRepository = productRepository,
        _storeRepository = storeRepository,
        super(const HomeLoading());

  // Icon mapping
  static const Map<String, String> _categoryIconMap = {
    'All': Assets.allCategories,
    'Food': Assets.food,
    'Drinks': Assets.drinks,
    'Clothes': Assets.clothes,
    'Electronics': Assets.food,
    'Fashion': Assets.clothes,
    'Home': Assets.food,
  };

  // Helper to get current loaded state
  HomeLoaded? get _currentLoadedState {
    final currentState = state;
    return currentState is HomeLoaded ? currentState : null;
  }

  // ========== INITIALIZATION ==========

  Future<void> initializeHome() async {
    emit(const HomeLoading());

    try {
      // Load initial data in parallel
      await Future.wait([
        _loadUserInfo(),
        _loadCategories(),
        _loadSpecialOffers(),
        _loadTrendingProducts(),
        _loadTopStores(),
      ]);

      // Ensure we have a loaded state
      if (state is! HomeLoaded) {
        emit(const HomeLoaded());
      }
    } catch (e) {
      emit(HomeError(
        message: 'Failed to load home data: ${e.toString()}',
      ));
    }
  }

  // ========== USER INFO ==========

  Future<void> _loadUserInfo() async {
    try {
      final currentState = _currentLoadedState ?? const HomeLoaded();

      // TODO: Replace with UserRepository when available
      final userInfo = HomeMockData.getUserInfo();

      emit(currentState.copyWith(
        userName: userInfo['name'] as String,
        userLocation: userInfo['location'] as String?,
      ));
    } catch (e) {
      print('Error loading user info: $e');
    }
  }

  // ========== CATEGORIES ==========

  Future<void> _loadCategories() async {
    final currentState = _currentLoadedState ?? const HomeLoaded();
    emit(currentState.copyWith(isCategoriesLoading: true));

    try {
      final categories = _categoryRepository != null
          ? await _categoryRepository.getCategories()
          : HomeMockData.getCategories();

      final categoriesWithIcons = categories.map((category) {
        final icon = _categoryIconMap[category.name] ?? Assets.allCategories;
        return CategoryPresentation(category: category, icon: icon);
      }).toList();

      final updatedState = _currentLoadedState ?? const HomeLoaded();
      emit(updatedState.copyWith(
        categories: categoriesWithIcons,
        isCategoriesLoading: false,
        clearError: true,
      ));
    } catch (e) {
      final updatedState = _currentLoadedState ?? const HomeLoaded();
      emit(updatedState.copyWith(
        isCategoriesLoading: false,
        errorMessage: 'Failed to load categories: ${e.toString()}',
      ));
    }
  }

  void selectCategory(int index) {
    final currentState = _currentLoadedState;
    if (currentState == null || index == currentState.selectedCategoryIndex) {
      return;
    }

    emit(currentState.copyWith(selectedCategoryIndex: index));

    // Reload products based on selected category
    if (index == 0) {
      _loadTrendingProducts();
    } else if (index < currentState.categories.length) {
      final categoryId = currentState.categories[index].category.id;
      _loadProductsByCategory(categoryId);
    }
  }

  // ========== SPECIAL OFFERS ==========

  Future<void> _loadSpecialOffers() async {
    final currentState = _currentLoadedState ?? const HomeLoaded();
    emit(currentState.copyWith(isOffersLoading: true));

    try {
      // TODO: Replace with OfferRepository when available
      final offers = HomeMockData.getSpecialOffers();

      final updatedState = _currentLoadedState ?? const HomeLoaded();
      emit(updatedState.copyWith(
        specialOffers: offers,
        isOffersLoading: false,
        clearError: true,
      ));
    } catch (e) {
      final updatedState = _currentLoadedState ?? const HomeLoaded();
      emit(updatedState.copyWith(
        isOffersLoading: false,
        errorMessage: 'Failed to load special offers: ${e.toString()}',
      ));
    }
  }

  void updateOfferPage(int page) {
    final currentState = _currentLoadedState;
    if (currentState != null) {
      emit(currentState.copyWith(currentOfferPage: page));
    }
  }

  void handleOfferTap(String offerId) {
    print('Offer tapped: $offerId');
    // TODO: Navigate to offer details
  }

  // ========== PRODUCTS ==========

  Future<void> _loadTrendingProducts() async {
    final currentState = _currentLoadedState ?? const HomeLoaded();
    emit(currentState.copyWith(isProductsLoading: true));

    try {
      final products = _productRepository != null
          ? await _productRepository.getTrendingProducts(limit: 10)
          : HomeMockData.getTrendingProducts(limit: 10);

      final updatedState = _currentLoadedState ?? const HomeLoaded();
      emit(updatedState.copyWith(
        trendingProducts: products,
        isProductsLoading: false,
        clearError: true,
      ));
    } catch (e) {
      final updatedState = _currentLoadedState ?? const HomeLoaded();
      emit(updatedState.copyWith(
        isProductsLoading: false,
        errorMessage: 'Failed to load products: ${e.toString()}',
      ));
    }
  }

  Future<void> _loadProductsByCategory(String categoryId) async {
    final currentState = _currentLoadedState ?? const HomeLoaded();
    emit(currentState.copyWith(isProductsLoading: true));

    try {
      final products = _productRepository != null
          ? await _productRepository.getProductsByCategory(
        categoryId: categoryId,
        limit: 10,
      )
          : HomeMockData.getProductsByCategory(
        categoryId: categoryId,
        limit: 10,
      );

      final updatedState = _currentLoadedState ?? const HomeLoaded();
      emit(updatedState.copyWith(
        trendingProducts: products,
        isProductsLoading: false,
        clearError: true,
      ));
    } catch (e) {
      final updatedState = _currentLoadedState ?? const HomeLoaded();
      emit(updatedState.copyWith(
        isProductsLoading: false,
        errorMessage: 'Failed to load products: ${e.toString()}',
      ));
    }
  }

  void incrementProduct(String productId) {
    final currentState = _currentLoadedState;
    if (currentState == null) return;

    final currentCount = currentState.productCounts[productId] ?? 0;
    final updatedCounts = Map<String, int>.from(currentState.productCounts);
    updatedCounts[productId] = currentCount + 1;

    emit(currentState.copyWith(productCounts: updatedCounts));
    // TODO: Update cart via CartRepository
  }

  void decrementProduct(String productId) {
    final currentState = _currentLoadedState;
    if (currentState == null) return;

    final currentCount = currentState.productCounts[productId] ?? 0;
    if (currentCount <= 0) return;

    final updatedCounts = Map<String, int>.from(currentState.productCounts);
    final newCount = currentCount - 1;

    if (newCount == 0) {
      updatedCounts.remove(productId);
    } else {
      updatedCounts[productId] = newCount;
    }

    emit(currentState.copyWith(productCounts: updatedCounts));
    // TODO: Update cart via CartRepository
  }

  void toggleProductFavorite(String productId) {
    final currentState = _currentLoadedState;
    if (currentState == null) return;

    final isFavorite = currentState.favoriteProductIds.contains(productId);
    final updatedFavorites = Set<String>.from(currentState.favoriteProductIds);

    if (isFavorite) {
      updatedFavorites.remove(productId);
    } else {
      updatedFavorites.add(productId);
    }

    emit(currentState.copyWith(
      favoriteProductIds: updatedFavorites,
      successMessage: isFavorite ? 'Removed from favorites' : 'Added to favorites',
    ));

    // TODO: Call ProductRepository.toggleFavoriteProduct
  }

  // ========== TOP STORES ==========

  Future<void> _loadTopStores() async {
    final currentState = _currentLoadedState ?? const HomeLoaded();
    emit(currentState.copyWith(isStoresLoading: true));

    try {
      final stores = _storeRepository != null
          ? await _storeRepository.getTopStores(limit: 10)
          : HomeMockData.getTopStores(limit: 10);

      final updatedState = _currentLoadedState ?? const HomeLoaded();
      emit(updatedState.copyWith(
        topStores: stores,
        isStoresLoading: false,
        clearError: true,
      ));
    } catch (e) {
      final updatedState = _currentLoadedState ?? const HomeLoaded();
      emit(updatedState.copyWith(
        isStoresLoading: false,
        errorMessage: 'Failed to load stores: ${e.toString()}',
      ));
    }
  }

  void toggleStoreFavorite(String storeId) {
    final currentState = _currentLoadedState;
    if (currentState == null) return;

    final isFavorite = currentState.favoriteStoreIds.contains(storeId);
    final updatedFavorites = Set<String>.from(currentState.favoriteStoreIds);

    if (isFavorite) {
      updatedFavorites.remove(storeId);
    } else {
      updatedFavorites.add(storeId);
    }

    emit(currentState.copyWith(
      favoriteStoreIds: updatedFavorites,
      successMessage:
      isFavorite ? 'Store removed from favorites' : 'Store added to favorites',
    ));

    // TODO: Call StoreRepository.toggleFavoriteStore
  }

  // ========== SEARCH ==========

  Future<void> searchProducts(String query) async {
    final currentState = _currentLoadedState ?? const HomeLoaded();

    if (query.trim().isEmpty) {
      emit(currentState.copyWith(
        searchQuery: '',
        isSearching: false,
        clearError: true,
      ));
      await _loadTrendingProducts();
      return;
    }

    if (query.trim().length < 2) {
      emit(currentState.copyWith(
        errorMessage: 'Search query must be at least 2 characters',
      ));
      return;
    }

    emit(currentState.copyWith(
      searchQuery: query,
      isSearching: true,
      isProductsLoading: true,
      clearError: true,
    ));

    try {
      final products = _productRepository != null
          ? await _productRepository.searchProducts(
        query: query.trim(),
        limit: 20,
      )
          : HomeMockData.searchProducts(
        query: query.trim(),
        limit: 20,
      );

      final updatedState = _currentLoadedState ?? const HomeLoaded();
      emit(updatedState.copyWith(
        trendingProducts: products,
        searchQuery: query,
        isProductsLoading: false,
        isSearching: false,
      ));
    } catch (e) {
      final updatedState = _currentLoadedState ?? const HomeLoaded();
      emit(updatedState.copyWith(
        isProductsLoading: false,
        isSearching: false,
        errorMessage: 'Search failed: ${e.toString()}',
      ));
    }
  }

  void handleFilterClick() {
    print('Filter clicked');
    // TODO: Show filter dialog/bottom sheet
  }

  // ========== UTILITY ==========

  void clearMessages() {
    final currentState = _currentLoadedState;
    if (currentState != null) {
      emit(currentState.copyWith(
        clearError: true,
        clearSuccess: true,
      ));
    }
  }
}