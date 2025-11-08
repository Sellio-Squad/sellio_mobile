import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';
import '../../../domain/repositories/category_repository.dart';
import '../../../domain/repositories/offers_repository.dart';
import '../../../domain/repositories/product_repository.dart';
import '../../../domain/repositories/store_repository.dart';
import '../../features/cart/cubit/cart_cubit.dart';
import '../../features/categories/cubit/categories_cubit.dart';
import '../../features/categories/cubit/categories_state.dart';
import '../../features/favorites/cubit/favorites_cubit.dart';
import '../../features/favorites/cubit/favorites_state.dart';
import '../../features/offers/cubit/offers_cubit.dart';
import '../../features/offers/cubit/offers_state.dart';
import '../../features/products/cubit/products_cubit.dart';
import '../../features/products/cubit/products_state.dart';
import '../../features/stores/cubit/stores_cubit.dart';
import '../../features/stores/cubit/stores_state.dart';
import '../../screens/store_details/store_details_screen.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/category_tabs.dart';
import 'widgets/products_section.dart';
import 'widgets/search_bar/search_widget.dart';
import 'widgets/special_offer/special_offers_section.dart';
import 'widgets/top_stores_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Screen-specific cubits
        BlocProvider(
          create: (context) => CategoriesCubit(
            context.read<CategoryRepository>(),
          )..loadCategories(),
        ),
        BlocProvider(
          create: (context) => ProductsCubit(
            context.read<ProductRepository>(),
          )..loadTrendingProducts(),
        ),
        BlocProvider(
          create: (context) => StoresCubit(
            context.read<StoreRepository>(),
          )..loadTopStores(),
        ),
        BlocProvider(
          create: (context) => OffersCubit(
            context.read<OffersRepository>(),
          )..loadSpecialOffers(),
        ),
      ],
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatelessWidget {
  const _HomeScreenContent();

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;

    return MultiBlocListener(
      listeners: [
        // Listen to category changes to reload products
        BlocListener<CategoriesCubit, CategoriesState>(
          listener: (context, state) {
            if (state is CategoriesLoaded) {
              final productsCubit = context.read<ProductsCubit>();

              if (state.selectedIndex == 0) {
                productsCubit.loadTrendingProducts();
              } else if (state.selectedIndex < state.categories.length) {
                final categoryId =
                    state.categories[state.selectedIndex].category.id;
                productsCubit.loadProductsByCategory(categoryId);
              }
            }
          },
        ),
        // Listen to product errors
        BlocListener<ProductsCubit, ProductsState>(
          listener: (context, state) {
            if (state is ProductsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: colors.red,
                ),
              );
            }
          },
        ),
        // Listen to category errors
        BlocListener<CategoriesCubit, CategoriesState>(
          listener: (context, state) {
            if (state is CategoriesError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: colors.red,
                ),
              );
            }
          },
        ),
        // Listen to stores errors
        BlocListener<StoresCubit, StoresState>(
          listener: (context, state) {
            if (state is StoresError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: colors.red,
                ),
              );
            }
          },
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: _buildAppBar(context),
          extendBodyBehindAppBar: true,
          backgroundColor: colors.surfaceLow,
          body: _buildBody(context, colors),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return const HomeAppBar(
      onNotificationTap: null, // TODO: Navigate to notifications
    );
  }

  Widget _buildBody(BuildContext context, dynamic colors) {
    return Stack(
      children: [
        // Gradient background
        Container(
          height: 256,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colors.primary.withOpacity(0.16),
                colors.primary.withOpacity(0.0),
              ],
            ),
          ),
        ),
        // Content
        SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              await Future.wait([
                context.read<CategoriesCubit>().loadCategories(),
                context.read<ProductsCubit>().loadTrendingProducts(),
                context.read<StoresCubit>().loadTopStores(),
                context.read<OffersCubit>().loadSpecialOffers(),
                context.read<CartCubit>().loadCart(),
                context.read<FavoritesCubit>().loadFavorites(),
              ]);
            },
            child: CustomScrollView(
              slivers: [
                _buildSearchBarSection(context),
                const CategoryTabs(),
                _buildSpecialOffersSection(),
                const ProductsSection(),
                _buildTopStoresSection(context),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 24),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  SliverToBoxAdapter _buildSearchBarSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: SearchBarWithFilter(
          onFilterIconClicked: () {
            // TODO: Show filter dialog
          },
          onTextSubmitted: (text) {
            context.read<ProductsCubit>().searchProducts(text);
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSpecialOffersSection() {
    return SliverToBoxAdapter(
      child: BlocBuilder<OffersCubit, OffersState>(
        builder: (context, state) {
          if (state is OffersLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is! OffersLoaded || state.offers.isEmpty) {
            return const SizedBox.shrink();
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
            child: SpecialOffersSection(
              offers: state.offers,
              currentPage: state.currentPage,
              onPageChanged: (page) {
                context.read<OffersCubit>().setCurrentPage(page);
              },
              onOfferTap: (offerId) {
                // TODO: Navigate to offer details
              },
            ),
          );
        },
      ),
    );
  }

  SliverToBoxAdapter _buildTopStoresSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<StoresCubit, StoresState>(
        builder: (context, storesState) {
          if (storesState is StoresLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (storesState is! StoresLoaded || storesState.stores.isEmpty) {
            return const SizedBox.shrink();
          }

          return BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, favState) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                child: TopStoresSection(
                  topStores: storesState.stores,
                  favoriteStoreIds: favState.storeIds,
                  onLikePressed: (storeId) {
                    context.read<FavoritesCubit>().toggleStoreFavorite(storeId);
                  },
                  onCardPressed: (store) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StoreDetailsScreen(
                          storeId: store.id,
                          coverImage: store.coverImage,
                          profileImage: store.profileImage,
                          storeName: store.name,
                          rating: store.rating,
                          discount: store.sale ?? '0',
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}