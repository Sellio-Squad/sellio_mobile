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
import '../../features/user/cubit/user_cubit.dart';
import '../../screens/store_details/store_details_screen.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';
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
        // Feature-specific cubits
        BlocProvider(
          create: (context) => CategoriesCubit(
            context.read<CategoryRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => ProductsCubit(
            context.read<ProductRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => StoresCubit(
            context.read<StoreRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => OffersCubit(
            context.read<OffersRepository>(),
          ),
        ),
        // Coordinator cubit
        BlocProvider(
          create: (context) => HomeCubit(
            categoriesCubit: context.read<CategoriesCubit>(),
            productsCubit: context.read<ProductsCubit>(),
            storesCubit: context.read<StoresCubit>(),
            offersCubit: context.read<OffersCubit>(),
            cartCubit: context.read<CartCubit>(),
            favoritesCubit: context.read<FavoritesCubit>(),
            userCubit: context.read<UserCubit>(),
          )..initializeHome(),
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
        BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: colors.red,
                  action: SnackBarAction(
                    label: 'Retry',
                    textColor: Colors.white,
                    onPressed: () {
                      context.read<HomeCubit>().initializeHome();
                    },
                  ),
                ),
              );
            } else if (state is HomeFilterRequested) {
              // TODO: Show filter bottom sheet
              _showFilterDialog(context);
            } else if (state is HomeNotificationRequested) {
              // TODO: Navigate to notifications
              print('Navigate to notifications');
            } else if (state is HomeOfferSelected) {
              // TODO: Navigate to offer details
              print('Navigate to offer: ${state.offerId}');
            } else if (state is HomeStoreSelected) {
              // TODO: Navigate to store details
              print('Navigate to store: ${state.storeId}');
            }
          },
        ),
        // Listen to category changes to reload products
        BlocListener<CategoriesCubit, CategoriesState>(
          listener: (context, state) {
            if (state is CategoriesLoaded) {
              context.read<HomeCubit>().onCategorySelected(
                state.selectedIndex,
                state.categories,
              );
            } else if (state is CategoriesError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: colors.red,
                ),
              );
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
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, homeState) {
          if (homeState is HomeLoading) {
            return Scaffold(
              backgroundColor: colors.surfaceLow,
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          // Show main content
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: _buildAppBar(context),
              extendBodyBehindAppBar: true,
              backgroundColor: colors.surfaceLow,
              body: _buildBody(context, colors),
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return HomeAppBar(
      onNotificationTap: () {
        context.read<HomeCubit>().onNotificationTapped();
      },
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
            onRefresh: () => context.read<HomeCubit>().refreshHome(),
            child: CustomScrollView(
              slivers: [
                _buildSearchBarSection(context),
                const CategoryTabs(),
                _buildSpecialOffersSection(context),
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
            context.read<HomeCubit>().onFilterPressed();
          },
          onTextSubmitted: (text) {
            context.read<HomeCubit>().onSearch(text);
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSpecialOffersSection(BuildContext context) {
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
                context.read<HomeCubit>().onOfferTapped(offerId);
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
                    context.read<HomeCubit>().onStoreTapped(store.id);
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

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Filter Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // TODO: Add filter options
              const Text('Filter options coming soon...'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}