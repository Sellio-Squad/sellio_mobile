import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/navigate/routing.dart';
import 'package:sellio_mobile/presentation/cubits/cart/cubit/cart_cubit.dart';
import 'package:sellio_mobile/presentation/cubits/cart/cubit/cart_state.dart';
import 'package:sellio_mobile/presentation/screens/store_details/widgets/store_details_screen_appBar_shimmer.dart';
import 'package:sellio_mobile/presentation/screens/store_details/widgets/store_details_screen_shimmer.dart';

import '../../../domain/entities/category.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/entities/store.dart';
import '../../../domain/entities/store_rating.dart';

import '../../cubits/favorites/cubit/favorites_cubit.dart';
import '../../cubits/favorites/cubit/favorites_state.dart';

import 'cubit/store_details_cubit.dart';
import 'cubit/store_details_state.dart';

import 'widgets/featured_items_section.dart';
import 'widgets/store_category_tabs.dart';
import 'widgets/store_header.dart';
import 'widgets/store_info_card.dart';
import 'widgets/store_products_list.dart';

class StoreDetailsScreen extends StatefulWidget {
  final String storeId;

  const StoreDetailsScreen({super.key, required this.storeId});

  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  late final StoreDetailsCubit cubit;
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    cubit = StoreDetailsCubit(context.read());
    cubit.loadStoreDetails(widget.storeId);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return BlocProvider.value(
      value: cubit,
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

  // ---------------- BODY ----------------

  Widget _buildBody(BuildContext context, StoreDetailsState state) {
    if (state is StoreDetailsLoading || state is StoreDetailsInitial) {
      return const StoreDetailsShimmer();
    }

    if (state is StoreDetailsError) {
      return Center(child: Text(state.message));
    }

    if (state is StoreDetailsLoaded) {
      final store = state.store;
      final rating = state.rating;
      final products = state.products ?? [];
      final featuredProducts = state.featuredProducts ?? [];

      return CustomScrollView(
        slivers: [
          _buildStoreHeader(store),
          if (rating != null) _buildStoreInfoCard(store, rating),
          if (featuredProducts.isNotEmpty)
            SliverToBoxAdapter(
              child: FeaturedItemsSection(products: featuredProducts),
            ),
          _buildCategoryTabs(store),
          _buildProductsList(products, store.categories),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  // ---------------- APP BAR ----------------

  PreferredSizeWidget _buildAppBar(
      BuildContext context,
      StoreDetailsState state,
      ) {
    final isLoading = state is StoreDetailsLoading;
    final storeName = state is StoreDetailsLoaded ? state.store.name : '';

    return SellioAppBar(
      showBackButton: true,
      title: storeName,
      actions: [
        isLoading
            ? const StoreAppbarShimmer(height: 20, width: 100)
            : _buildStoreFavoriteButton(state),
      ],
    );
  }

  Widget _buildStoreFavoriteButton(StoreDetailsState state) {
    if (state is! StoreDetailsLoaded) return const SizedBox.shrink();
    final store = state.store;

    return BlocBuilder<FavoritesCubit, FavoritesState>(
      buildWhen: (prev, curr) {
        if (prev is FavoritesLoaded && curr is FavoritesLoaded) {
          return prev.favoriteStoreIds != curr.favoriteStoreIds;
        }

        return curr is FavoritesLoaded;
      },
      builder: (context, favState) {
        final isFavorite = favState is FavoritesLoaded
            ? favState.favoriteStoreIds.contains(store.id)
            : store.isFavorite;

        return IconButton(
          icon: SvgPicture.asset(
            isFavorite ? AppImages.favorite : AppImages.unselectedFavorite,
          ),
          onPressed: () {
            context.read<FavoritesCubit>().toggleFavorite(store.id, FavoriteType.store);
          },
        );
      },
    );
  }

  Widget _buildStoreHeader(Store store) {

    return SliverToBoxAdapter(
      child: StoreHeader(
        coverImage: store.coverImage,
        profileImage: store.profileImage,
        storeName: store.name,
        discount: store.sale ?? '',
        description: store.description,
        address: [store.address.country, store.address.city],
        rating: store.rating,
        subcategories: store.categories.map((c) => c.name).toList(),
      ),
    );
  }

  Widget _buildStoreInfoCard(Store store, StoreRating rating) {
    return SliverToBoxAdapter(
      child: StoreInfoOverview(
        location: store.address.city,
        rating: rating.averageRating,
        tags: store.categories.map((e) => e.name).toList(),
        description: store.description,
      ),
    );
  }

  Widget _buildCategoryTabs(Store store) {
    return SliverToBoxAdapter(
      child: StoreCategoryTabs(
        categories: store.categories,
        selectedIndex: _selectedCategoryIndex,
        onCategorySelected: (index) {
          setState(() => _selectedCategoryIndex = index);
        },
      ),
    );
  }

  Widget _buildProductsList(
      List<Product> products,
      List<Category> categories,
      ) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cartState) {
        return SliverPadding(
          padding: const EdgeInsets.all(LayoutConstants.paddingHorizontal),
          sliver: StoreProductsList(
            products: products,
            categories: categories.map((c) => c.id).toList(),
            categoryIndex: _selectedCategoryIndex,
            onTap: (product) {
              context.navigator.pushProductDetails(
                ProductDetailsArgs(productId: product.id),
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }
}