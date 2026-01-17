import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/presentation/cubits/cart/cubit/cart_cubit.dart';
import 'package:sellio_mobile/presentation/cubits/cart/cubit/cart_state.dart';
import '../../../../../../domain/repositories/store_repository.dart';
import 'package:design_system/design_system.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/entities/store.dart';
import '../../../domain/entities/store_rating.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';
import 'package:design_system/design_system.dart';
import 'cubit/store_details_cubit.dart';
import 'cubit/store_details_state.dart';
import 'widgets/featured_items_section.dart';
import 'widgets/store_category_tabs.dart';
import 'widgets/store_header.dart';
import 'widgets/store_info_card.dart';
import 'widgets/store_products_list.dart';

class StoreDetailsScreen extends StatefulWidget {
  final String storeId;

  const StoreDetailsScreen({
    super.key,
    required this.storeId,
  });

  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  int _selectedCategoryIndex = 0;
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;

    return BlocProvider(
      create: (context) => StoreDetailsCubit(context.read<StoreRepository>())
        ..loadStoreDetails(widget.storeId),
      child: BlocBuilder<StoreDetailsCubit, StoreDetailsState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: colors.surfaceLow,
            appBar: _buildAppBar(context, state),
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, StoreDetailsState state) {
    if (state is StoreDetailsLoading || state is StoreDetailsInitial) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is StoreDetailsError) {
      return _buildErrorView(context, state);
    }

    if (state is StoreDetailsLoaded) {
      final store = state.store;
      final rating = state.rating;
      final products = state.products;
      final featuredProducts = state.featuredProducts;
      final categories = store.categories;

      return CustomScrollView(
        slivers: [
          _buildStoreHeader(store),
          // Only show info card if rating is available
          if (rating != null) _buildStoreInfoCard(store, rating),
          // Only show featured items if featured products are available and not empty
          if (featuredProducts != null && featuredProducts.isNotEmpty) 
            _buildFeaturedItemsSection(featuredProducts),
          _buildSectionSpacing(),
          // Only show category tabs if products are available and categories exist
          if (products != null && categories.isNotEmpty) 
            _buildCategoryTabs(store),
          // Only show products list if products are available
          if (products != null && products.isNotEmpty)
            _buildProductsList(products, categories),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildErrorView(BuildContext context, StoreDetailsError state) {
    final theme = context.theme;
    final colors = theme.colors;
    final textTheme = theme.typography.textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Unable to load store details',
              style: textTheme.headlineSmall.copyWith(
                color: colors.title,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              state.message,
              style: textTheme.bodyMedium.copyWith(
                color: colors.body,
              ),
              textAlign: TextAlign.center,
            ),
            if (state.failedCall != null) ...[
              const SizedBox(height: 8),
              Text(
                'Failed to load: ${state.failedCall}',
                style: textTheme.bodySmall.copyWith(
                  color: colors.hint,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<StoreDetailsCubit>().retry();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoProductsMessage() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No products available',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreHeader(Store store) {
    return SliverToBoxAdapter(
      child: StoreHeader(
        coverImage: store.coverImage.isNotEmpty 
            ? store.coverImage 
            : AppImages.storeSweet,
        profileImage: store.profileImage.isNotEmpty 
            ? store.profileImage 
            : AppImages.placeholder,
        storeName: store.name.isNotEmpty ? store.name : 'Store',
        discount: store.sale ?? '',
      ),
    );
  }

  Widget _buildStoreInfoCard(Store store, StoreRating rating) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          LayoutConstants.paddingHorizontal,
          LayoutConstants.paddingVertical,
          LayoutConstants.paddingHorizontal,
          LayoutConstants.paddingVertical,
        ),
        child: StoreInfoOverview(
          location: store.address.city.isNotEmpty ? store.address.city : 'Unknown',
          rating: rating.averageRating.clamp(0.0, 5.0),
          tags: store.categories.map((category) => category.name).toList(),
          description: store.description.isNotEmpty ? store.description : 'No description available',
        ),
      ),
    );
  }

  Widget _buildFeaturedItemsSection(List<Product> products) {
    return SliverToBoxAdapter(
      child: FeaturedItemsSection(products: products),
    );
  }

  Widget _buildSectionSpacing() => const SliverToBoxAdapter(
        child: SizedBox(height: LayoutConstants.sectionSpacing),
      );

  Widget _buildCategoryTabs(Store store) {
    return SliverToBoxAdapter(
      child: StoreCategoryTabs(
        categories: store.categories,
        selectedIndex: _selectedCategoryIndex,
        onCategorySelected: _onCategorySelected,
      ),
    );
  }

  Widget _buildProductsList(List<Product> products, List<Category> categories) {
    if (products.isEmpty) {
      return _buildNoProductsMessage();
    }

    return BlocBuilder<CartCubit, CartState>(
      builder: (BuildContext context, cartState) {
        return SliverPadding(
          padding: const EdgeInsets.all(LayoutConstants.paddingHorizontal),
          sliver: StoreProductsList(
            onTap: () {
              if (products.isNotEmpty) {
                context.navigator.pushProductDetails(
                  ProductDetailsArgs(
                    productId: products[0].id,
                  ),
                );
              }
            },
            categoryIndex: _selectedCategoryIndex,
            products: products,
            categories: categories.map((c) => c.id).toList(),
            onIncrement: () {
              if (products.isNotEmpty) {
                context.read<CartCubit>().incrementProduct(products[0].id);
              }
            },
            onDecrement: () {
              if (products.isNotEmpty) {
                context.read<CartCubit>().decrementProduct(products[0].id);
              }
            },
            count: products.isNotEmpty 
                ? (cartState.productCounts[products[0].id] ?? 0)
                : 0,
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(
      BuildContext context, StoreDetailsState state) {
    final theme = context.theme;
    final colors = theme.colors;

    final storeName = state is StoreDetailsLoaded ? state.store.name : '';

    return SellioAppBar(
      showBackButton: true,
      title: storeName,
      actions: [
        _buildFavoriteButton(colors),
        _buildInfoButton(),
      ],
    );
  }

  Widget _buildFavoriteButton(dynamic colors) {
    return IconButton(
      icon: SvgPicture.asset(
        _isFavorite ? AppImages.favorite : AppImages.unselectedFavorite,
        width: LayoutConstants.iconSizeMedium,
        height: LayoutConstants.iconSizeMedium,
      ),
      onPressed: _toggleFavorite,
    );
  }

  Widget _buildInfoButton() {
    return IconButton(
      icon: SvgPicture.asset(
        AppImages.alertCircle,
        width: LayoutConstants.iconSizeMedium,
        height: LayoutConstants.iconSizeMedium,
      ),
      onPressed: _navigateToAboutStore,
    );
  }

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void _navigateToAboutStore() {
    context.navigator.pushAboutStore(
      AboutStoreArgs(storeId: widget.storeId),
    );
  }
}
