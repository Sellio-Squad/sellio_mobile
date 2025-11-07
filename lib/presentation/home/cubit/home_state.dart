import 'package:equatable/equatable.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/entities/store.dart';
import '../../../domain/entities/special_offer.dart';
import '../../../domain/entities/category.dart';

// ========== MAIN SEALED STATE ==========
sealed class HomeState extends Equatable {
  const HomeState();
}

// ========== LOADING STATE ==========
class HomeLoading extends HomeState {
  const HomeLoading();

  @override
  List<Object?> get props => [];
}

// ========== LOADED STATE ==========
class HomeLoaded extends HomeState {
  // User info
  final String userName;
  final String? userLocation;

  // Categories
  final List<CategoryPresentation> categories;
  final int selectedCategoryIndex;

  // Special Offers
  final List<SpecialOffer> specialOffers;
  final int currentOfferPage;

  // Products
  final List<Product> trendingProducts;
  final Map<String, int> productCounts;
  final Set<String> favoriteProductIds;

  // Top Stores
  final List<Store> topStores;
  final Set<String> favoriteStoreIds;

  // Search
  final String searchQuery;

  // Section loading states
  final bool isCategoriesLoading;
  final bool isOffersLoading;
  final bool isProductsLoading;
  final bool isStoresLoading;
  final bool isSearching;

  // Messages (optional, cleared after display)
  final String? errorMessage;
  final String? successMessage;

  const HomeLoaded({
    this.userName = 'Guest',
    this.userLocation,
    this.categories = const [],
    this.selectedCategoryIndex = 0,
    this.specialOffers = const [],
    this.currentOfferPage = 0,
    this.trendingProducts = const [],
    this.productCounts = const {},
    this.favoriteProductIds = const {},
    this.topStores = const [],
    this.favoriteStoreIds = const {},
    this.searchQuery = '',
    this.isCategoriesLoading = false,
    this.isOffersLoading = false,
    this.isProductsLoading = false,
    this.isStoresLoading = false,
    this.isSearching = false,
    this.errorMessage,
    this.successMessage,
  });

  HomeLoaded copyWith({
    String? userName,
    String? userLocation,
    List<CategoryPresentation>? categories,
    int? selectedCategoryIndex,
    List<SpecialOffer>? specialOffers,
    int? currentOfferPage,
    List<Product>? trendingProducts,
    Map<String, int>? productCounts,
    Set<String>? favoriteProductIds,
    List<Store>? topStores,
    Set<String>? favoriteStoreIds,
    String? searchQuery,
    bool? isCategoriesLoading,
    bool? isOffersLoading,
    bool? isProductsLoading,
    bool? isStoresLoading,
    bool? isSearching,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
  }) {
    return HomeLoaded(
      userName: userName ?? this.userName,
      userLocation: userLocation ?? this.userLocation,
      categories: categories ?? this.categories,
      selectedCategoryIndex: selectedCategoryIndex ?? this.selectedCategoryIndex,
      specialOffers: specialOffers ?? this.specialOffers,
      currentOfferPage: currentOfferPage ?? this.currentOfferPage,
      trendingProducts: trendingProducts ?? this.trendingProducts,
      productCounts: productCounts ?? this.productCounts,
      favoriteProductIds: favoriteProductIds ?? this.favoriteProductIds,
      topStores: topStores ?? this.topStores,
      favoriteStoreIds: favoriteStoreIds ?? this.favoriteStoreIds,
      searchQuery: searchQuery ?? this.searchQuery,
      isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
      isOffersLoading: isOffersLoading ?? this.isOffersLoading,
      isProductsLoading: isProductsLoading ?? this.isProductsLoading,
      isStoresLoading: isStoresLoading ?? this.isStoresLoading,
      isSearching: isSearching ?? this.isSearching,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      successMessage: clearSuccess ? null : (successMessage ?? this.successMessage),
    );
  }

  @override
  List<Object?> get props => [
    userName,
    userLocation,
    categories,
    selectedCategoryIndex,
    specialOffers,
    currentOfferPage,
    trendingProducts,
    productCounts,
    favoriteProductIds,
    topStores,
    favoriteStoreIds,
    searchQuery,
    isCategoriesLoading,
    isOffersLoading,
    isProductsLoading,
    isStoresLoading,
    isSearching,
    errorMessage,
    successMessage,
  ];
}

// ========== ERROR STATE (only for fatal errors) ==========
class HomeError extends HomeState {
  final String message;

  const HomeError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

// ========== HELPER CLASSES ==========
class CategoryPresentation extends Equatable {
  final Category category;
  final String icon;

  const CategoryPresentation({
    required this.category,
    required this.icon,
  });

  @override
  List<Object?> get props => [category, icon];
}