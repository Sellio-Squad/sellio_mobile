import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/design_system/constants/assets.dart';
import '../../../domain/entities/address.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/entities/special_offer.dart';
import '../../../domain/entities/store.dart';
import '../../../domain/repositories/category_repository.dart';
import '../../../domain/repositories/product_repository.dart';
import '../../../domain/repositories/store_repository.dart';
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
        super(const HomeState());

  // Icon mapping - Presentation layer concern
  static const Map<String, String> _categoryIconMap = {
    'All': Assets.allCategories,
    'Food': Assets.food,
    'Drinks': Assets.drinks,
    'Clothes': Assets.clothes,
    'Electronics': Assets.food, // You can add more icons
    'Fashion': Assets.clothes,
    'Home': Assets.food,
  };

  // ========== INITIALIZATION ==========

  Future<void> initializeHome() async {
    emit(state.copyWith(isInitialLoading: true, error: null));

    try {
      // Load initial data
      await Future.wait([
        _loadUserInfo(),
        _loadCategories(),
        _loadSpecialOffers(),
        _loadTrendingProducts(),
        _loadTopStores(),
      ]);

      emit(state.copyWith(isInitialLoading: false));
    } catch (e) {
      emit(state.copyWith(
        isInitialLoading: false,
        error: 'Failed to load home data: ${e.toString()}',
      ));
    }
  }

  // ========== USER INFO ==========

  Future<void> _loadUserInfo() async {
    try {
      // TODO: Load from UserRepository when available
      emit(state.copyWith(
        userName: 'John Doe',
        userLocation: 'Baghdad, Iraq',
      ));
    } catch (e) {
      print('Error loading user info: $e');
    }
  }

  // ========== CATEGORIES ==========

  Future<void> _loadCategories() async {
    emit(state.copyWith(isCategoriesLoading: true));

    try {
      final categories = _categoryRepository != null
          ? await _categoryRepository.getCategories()
          : _getMockCategories();

      // Map domain categories to presentation with icons
      final categoriesWithIcons = categories.map((category) {
        final icon = _categoryIconMap[category.name] ?? Assets.allCategories;
        return CategoryPresentation(
          category: category,
          icon: icon,
        );
      }).toList();

      emit(state.copyWith(
        categories: categoriesWithIcons,
        isCategoriesLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isCategoriesLoading: false,
        error: 'Failed to load categories: ${e.toString()}',
      ));
    }
  }

  void selectCategory(int index) {
    if (index != state.selectedCategoryIndex) {
      emit(state.copyWith(selectedCategoryIndex: index));

      // Reload products based on selected category
      if (index == 0) {
        // "All" category
        _loadTrendingProducts();
      } else if (index < state.categories.length) {
        final categoryId = state.categories[index].category.id;
        _loadProductsByCategory(categoryId);
      }
    }
  }

  // ========== SPECIAL OFFERS ==========

  Future<void> _loadSpecialOffers() async {
    emit(state.copyWith(isOffersLoading: true));

    try {
      // Mock data for now
      final offers = _getMockSpecialOffers();

      emit(state.copyWith(
        specialOffers: offers,
        isOffersLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isOffersLoading: false,
        error: 'Failed to load special offers: ${e.toString()}',
      ));
    }
  }

  void updateOfferPage(int page) {
    emit(state.copyWith(currentOfferPage: page));
  }

  void handleOfferTap(String offerId) {
    print('Offer tapped: $offerId');
    // TODO: Navigate to offer details
  }

  // ========== PRODUCTS ==========

  Future<void> _loadTrendingProducts() async {
    emit(state.copyWith(isProductsLoading: true));

    try {
      final products = _productRepository != null
          ? await _productRepository.getTrendingProducts(limit: 10)
          : _getMockProducts();

      emit(state.copyWith(
        trendingProducts: products,
        isProductsLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isProductsLoading: false,
        error: 'Failed to load products: ${e.toString()}',
      ));
    }
  }

  Future<void> _loadProductsByCategory(String categoryId) async {
    emit(state.copyWith(isProductsLoading: true));

    try {
      final products = _productRepository != null
          ? await _productRepository.getProductsByCategory(
              categoryId: categoryId,
              limit: 10,
            )
          : _getMockProducts();

      emit(state.copyWith(
        trendingProducts: products,
        isProductsLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isProductsLoading: false,
        error: 'Failed to load products: ${e.toString()}',
      ));
    }
  }

  void incrementProduct(String productId) {
    final currentCount = state.productCounts[productId] ?? 0;
    final newCount = currentCount + 1;

    final updatedCounts = Map<String, int>.from(state.productCounts);
    updatedCounts[productId] = newCount;
    emit(state.copyWith(productCounts: updatedCounts));

    // TODO: Update cart via CartRepository
  }

  void decrementProduct(String productId) {
    final currentCount = state.productCounts[productId] ?? 0;
    if (currentCount <= 0) return;

    final newCount = currentCount - 1;
    final updatedCounts = Map<String, int>.from(state.productCounts);

    if (newCount == 0) {
      updatedCounts.remove(productId);
    } else {
      updatedCounts[productId] = newCount;
    }

    emit(state.copyWith(productCounts: updatedCounts));

    // TODO: Update cart via CartRepository
  }

  void toggleProductFavorite(String productId) {
    final isFavorite = state.favoriteProductIds.contains(productId);
    final updatedFavorites = Set<String>.from(state.favoriteProductIds);

    if (isFavorite) {
      updatedFavorites.remove(productId);
    } else {
      updatedFavorites.add(productId);
    }

    emit(state.copyWith(
      favoriteProductIds: updatedFavorites,
      successMessage:
          isFavorite ? 'Removed from favorites' : 'Added to favorites',
    ));

    // TODO: Call ProductRepository.toggleFavoriteProduct
  }

  // ========== TOP STORES ==========

  Future<void> _loadTopStores() async {
    emit(state.copyWith(isStoresLoading: true));

    try {
      final stores = _storeRepository != null
          ? await _storeRepository!.getTopStores(limit: 10)
          : _getMockStores();

      emit(state.copyWith(
        topStores: stores,
        isStoresLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isStoresLoading: false,
        error: 'Failed to load stores: ${e.toString()}',
      ));
    }
  }

  void toggleStoreFavorite(String storeId) {
    final isFavorite = state.favoriteStoreIds.contains(storeId);
    final updatedFavorites = Set<String>.from(state.favoriteStoreIds);

    if (isFavorite) {
      updatedFavorites.remove(storeId);
    } else {
      updatedFavorites.add(storeId);
    }

    emit(state.copyWith(
      favoriteStoreIds: updatedFavorites,
      successMessage: isFavorite
          ? 'Store removed from favorites'
          : 'Store added to favorites',
    ));

    // TODO: Call StoreRepository.toggleFavoriteStore
  }

  // ========== SEARCH ==========

  Future<void> searchProducts(String query) async {
    if (query.trim().isEmpty) {
      emit(state.copyWith(
        searchQuery: '',
        isSearching: false,
      ));
      await _loadTrendingProducts();
      return;
    }

    if (query.trim().length < 2) {
      emit(state.copyWith(
        error: 'Search query must be at least 2 characters',
      ));
      return;
    }

    emit(state.copyWith(
      searchQuery: query,
      isSearching: true,
      isProductsLoading: true,
    ));

    try {
      final products = _productRepository != null
          ? await _productRepository.searchProducts(
              query: query.trim(),
              limit: 20,
            )
          : _getMockProducts()
              .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
              .toList();

      emit(state.copyWith(
        trendingProducts: products,
        isProductsLoading: false,
        isSearching: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isProductsLoading: false,
        isSearching: false,
        error: 'Search failed: ${e.toString()}',
      ));
    }
  }

  void handleFilterClick() {
    print('Filter clicked');
    // TODO: Show filter dialog/bottom sheet
  }

  // ========== UTILITY ==========

  void clearMessages() {
    emit(state.copyWith(error: null, successMessage: null));
  }

  // ========== MOCK DATA ==========

  List<Category> _getMockCategories() {
    return [
      const Category(id: 'all', name: 'All'),
      const Category(id: '1', name: 'Food'),
      const Category(id: '2', name: 'Drinks'),
      const Category(id: '3', name: 'Clothes'),
    ];
  }

  List<Product> _getMockProducts() {
    return [
      Product(
        id: '1',
        name: 'Gold Stainless Steel Sun Charm Necklace',
        description: 'Beautiful gold necklace with sun charm',
        price: 7.00,
        discount: '30% OFF',
        images: ['assets/images/product_3.webp'],
        storeId: '1',
        categoryId: '3',
        currency: 'EG',
      ),
      Product(
        id: '2',
        name: 'Birthday Cake with Bows',
        description: 'Delicious birthday cake',
        price: 12.99,
        images: ['assets/images/product_3.webp'],
        storeId: '1',
        categoryId: '1',
        currency: 'EG',
      ),
      Product(
        id: '3',
        name: 'Chocolate Brownie',
        description: 'Rich chocolate brownie',
        price: 10.99,
        images: ['assets/images/product_3.webp'],
        storeId: '2',
        categoryId: '1',
        currency: 'EG',
      ),
    ];
  }

  List<Store> _getMockStores() {
    return [
      Store(
        id: '1',
        name: 'Gold Gallery Accessories',
        description: 'Premium jewelry and accessories',
        coverImage: 'assets/images/store_sweet.webp',
        profileImage: 'assets/images/store_sweet.webp',
        sale: '25',
        rating: 4.5,
        address: const Address(
          id: '1',
          country: 'Iraq',
          city: 'Baghdad',
          latitude: 33.3152,
          longitude: 44.3661,
        ),
        contactInfo: ContactInfo(
          provider: 'gold@gallery.com',
          type: ContactType.email,
        ),
        categories: [
          const Category(id: '1', name: 'Jewelry'),
        ],
      ),
      Store(
        id: '2',
        name: 'Sweet Cake Sweet',
        description: 'Delicious cakes and desserts',
        coverImage: 'assets/images/store_sweet.webp',
        profileImage: 'assets/images/store_sweet.webp',
        sale: '30',
        rating: 4.8,
        address: const Address(
          id: '2',
          country: 'Iraq',
          city: 'Baghdad',
          latitude: 33.3152,
          longitude: 44.3661,
        ),
        contactInfo: ContactInfo(
          provider: 'sweet@cake.com',
          type: ContactType.email,
        ),
        categories: [
          const Category(id: '1', name: 'Food'),
        ],
      ),
      Store(
        id: '3',
        name: 'Techno Store',
        description: 'Latest tech gadgets',
        coverImage: 'assets/images/store_sweet.webp',
        profileImage: 'assets/images/store_sweet.webp',
        rating: 4.2,
        address: const Address(
          id: '3',
          country: 'Iraq',
          city: 'Baghdad',
          latitude: 33.3152,
          longitude: 44.3661,
        ),
        contactInfo: ContactInfo(
          provider: 'info@techno.com',
          type: ContactType.email,
        ),
        categories: [
          const Category(id: '2', name: 'Electronics'),
        ],
      ),
    ];
  }

  List<SpecialOffer> _getMockSpecialOffers() {
    return [
      SpecialOffer(
        id: '1',
        title: 'Get 10% off on your first order',
        imageUrl:
            'https://img.freepik.com/free-psd/ocean-wave-crashing-sandy-beach-summer-vacation-paradise_191095-79314.jpg',
        discount: '25% OFF',
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 7)),
        createdAt: DateTime.now(),
      ),
      SpecialOffer(
        id: '2',
        title: 'Summer Sale',
        imageUrl:
            'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
        discount: '30% OFF',
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 7)),
        createdAt: DateTime.now(),
      ),
      SpecialOffer(
        id: '3',
        title: 'Weekend Special',
        imageUrl: 'https://images.unsplash.com/photo-1558089551-95d707e6c13c',
        discount: '20% OFF',
        startDate: DateTime.now().subtract(const Duration(days: 1)),
        endDate: DateTime.now().add(const Duration(days: 2)),
        createdAt: DateTime.now(),
      ),
    ];
  }
}
