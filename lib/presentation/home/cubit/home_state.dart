import 'package:equatable/equatable.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/entities/store.dart';
import '../../../domain/entities/special_offer.dart';
import '../../../domain/entities/category.dart';

class HomeState extends Equatable {
  // User info
  final String userName;
  final String? userLocation;

  // Categories with presentation icons mapping
  final List<CategoryPresentation> categories;
  final int selectedCategoryIndex;
  final bool isCategoriesLoading;

  // Special Offers
  final List<SpecialOffer> specialOffers;
  final int currentOfferPage;
  final bool isOffersLoading;

  // Products
  final List<Product> trendingProducts;
  final Map<String, int> productCounts; // productId -> quantity
  final Set<String> favoriteProductIds;
  final bool isProductsLoading;

  // Top Stores
  final List<Store> topStores;
  final Set<String> favoriteStoreIds;
  final bool isStoresLoading;

  // Search
  final String searchQuery;
  final bool isSearching;

  // Error handling
  final String? error;
  final String? successMessage;

  // Loading states
  final bool isInitialLoading;

  const HomeState({
    this.userName = 'Guest',
    this.userLocation,
    this.categories = const [],
    this.selectedCategoryIndex = 0,
    this.isCategoriesLoading = false,
    this.specialOffers = const [],
    this.currentOfferPage = 0,
    this.isOffersLoading = false,
    this.trendingProducts = const [],
    this.productCounts = const {},
    this.favoriteProductIds = const {},
    this.isProductsLoading = false,
    this.topStores = const [],
    this.favoriteStoreIds = const {},
    this.isStoresLoading = false,
    this.searchQuery = '',
    this.isSearching = false,
    this.error,
    this.successMessage,
    this.isInitialLoading = true,
  });

  HomeState copyWith({
    String? userName,
    String? userLocation,
    List<CategoryPresentation>? categories,
    int? selectedCategoryIndex,
    bool? isCategoriesLoading,
    List<SpecialOffer>? specialOffers,
    int? currentOfferPage,
    bool? isOffersLoading,
    List<Product>? trendingProducts,
    Map<String, int>? productCounts,
    Set<String>? favoriteProductIds,
    bool? isProductsLoading,
    List<Store>? topStores,
    Set<String>? favoriteStoreIds,
    bool? isStoresLoading,
    String? searchQuery,
    bool? isSearching,
    String? error,
    String? successMessage,
    bool? isInitialLoading,
  }) {
    return HomeState(
      userName: userName ?? this.userName,
      userLocation: userLocation ?? this.userLocation,
      categories: categories ?? this.categories,
      selectedCategoryIndex: selectedCategoryIndex ?? this.selectedCategoryIndex,
      isCategoriesLoading: isCategoriesLoading ?? this.isCategoriesLoading,
      specialOffers: specialOffers ?? this.specialOffers,
      currentOfferPage: currentOfferPage ?? this.currentOfferPage,
      isOffersLoading: isOffersLoading ?? this.isOffersLoading,
      trendingProducts: trendingProducts ?? this.trendingProducts,
      productCounts: productCounts ?? this.productCounts,
      favoriteProductIds: favoriteProductIds ?? this.favoriteProductIds,
      isProductsLoading: isProductsLoading ?? this.isProductsLoading,
      topStores: topStores ?? this.topStores,
      favoriteStoreIds: favoriteStoreIds ?? this.favoriteStoreIds,
      isStoresLoading: isStoresLoading ?? this.isStoresLoading,
      searchQuery: searchQuery ?? this.searchQuery,
      isSearching: isSearching ?? this.isSearching,
      error: error,
      successMessage: successMessage,
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
    );
  }

  @override
  List<Object?> get props => [
    userName,
    userLocation,
    categories,
    selectedCategoryIndex,
    isCategoriesLoading,
    specialOffers,
    currentOfferPage,
    isOffersLoading,
    trendingProducts,
    productCounts,
    favoriteProductIds,
    isProductsLoading,
    topStores,
    favoriteStoreIds,
    isStoresLoading,
    searchQuery,
    isSearching,
    error,
    successMessage,
    isInitialLoading,
  ];
}

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