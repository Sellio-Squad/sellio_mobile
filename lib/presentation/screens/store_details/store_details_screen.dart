import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/app_management/route/routing.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import 'package:sellio_mobile/presentation/cubits/cart/cubit/cart_cubit.dart';
import 'package:sellio_mobile/presentation/cubits/cart/cubit/cart_state.dart';

import '../../../../../../domain/repositories/store_repository.dart';
import '../../../core/design_system/constants/app_images.dart';
import '../../../domain/entities/StoreRating.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/entities/store.dart';
import 'cubit/store_details_cubit.dart';
import 'cubit/store_details_state.dart';
import 'widgets/featured_items_section.dart';
import 'widgets/store_category_tabs.dart';
import 'widgets/store_header.dart';
import 'widgets/store_info_card.dart';
import 'widgets/store_products_list.dart';

class StoreDetailsScreen extends StatefulWidget {
  final String storeId;
  final String coverImage;
  final String profileImage;
  final String storeName;
  final String discount;
  final double rating;

  const StoreDetailsScreen({
    super.key,
    required this.storeId,
    required this.coverImage,
    required this.profileImage,
    required this.storeName,
    required this.discount,
    required this.rating,
  });

  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  static const double _horizontalPadding = 16.0;
  static const double _verticalPadding = 8.0;
  static const double _sectionSpacing = 8.0;
  static const double _iconSize = 24.0;

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
            appBar: _buildAppBar(context),
            body: _buildBody(state),
          );
        },
      ),
    );
  }

  Widget _buildBody(StoreDetailsState state) {
    if (state is StoreDetailsLoading || state is StoreDetailsInitial) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is StoreDetailsError) {
      return Center(child: Text(state.message));
    }

    if (state is StoreDetailsLoaded) {
      final store = state.store;
      final rating = state.rating;
      final products = state.products;
      final categories = store.categories;

      return CustomScrollView(
        slivers: [
          _buildStoreHeader(),
          _buildStoreInfoCard(store, rating),
          _buildFeaturedItemsSection(products),
          _buildSectionSpacing(),
          _buildCategoryTabs(store),
          _buildProductsList(products, categories),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildStoreHeader() {
    return SliverToBoxAdapter(
      child: StoreHeader(
        coverImage: widget.coverImage,
        profileImage: widget.profileImage,
        storeName: widget.storeName,
        discount: widget.discount,
      ),
    );
  }

  Widget _buildStoreInfoCard(Store store, StoreRating rating) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          _horizontalPadding,
          _verticalPadding,
          _horizontalPadding,
          _verticalPadding,
        ),
        child: StoreInfoOverview(
          location: store.address.city,
          rating: rating.averageRating,
          tags: store.categories.map((category) => category.name).toList(),
          description: store.description,
        ),
      ),
    );
  }

  Widget _buildFeaturedItemsSection(List<Product> products) {
    return SliverToBoxAdapter(
      child: FeaturedItemsSection(
        products: products,
      ),
    );
  }

  Widget _buildSectionSpacing() =>
      const SliverToBoxAdapter(child: SizedBox(height: _sectionSpacing));

  Widget _buildCategoryTabs(store) {
    return SliverToBoxAdapter(
      child: StoreCategoryTabs(
        categories: store.categories,
        selectedIndex: _selectedCategoryIndex,
        onCategorySelected: _onCategorySelected,
      ),
    );
  }

  Widget _buildProductsList(List<Product> products, List<Category> categories) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (BuildContext context, cartState) {
        return SliverPadding(
          padding: const EdgeInsets.all(_horizontalPadding),
          sliver: StoreProductsList(
            onTap: () => context.navigator.pushProductDetails(
              ProductDetailsArgs(
                productId: products[0].id,
                productDescription: products[0].description,
                productPrice: products[0].price,
              ),
            ),
            categoryIndex: _selectedCategoryIndex,
            products: products,
            categories: categories.map((c) => c.id).toList(),
            onIncrement: () {
              context.read<CartCubit>().incrementProduct(products[0].id);
            },
            onDecrement: () {
              context.read<CartCubit>().decrementProduct(products[0].id);
            },
            count: cartState.productCounts[products[0].id] ?? 0,
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;

    return SellioAppBar(
      showBackButton: true,
      title: widget.storeName,
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
        width: _iconSize,
        height: _iconSize,
      ),
      onPressed: _toggleFavorite,
    );
  }

  Widget _buildInfoButton() {
    return IconButton(
      icon: SvgPicture.asset(
        AppImages.alertCircle,
        width: _iconSize,
        height: _iconSize,
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
