import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';
import '../screens/store_details/store_details_screen.dart';
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
    return BlocProvider(
      create: (context) => HomeCubit(
        categoryRepository: null,
        productRepository: null,
        storeRepository: null,
      )..initializeHome(),
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

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeLoaded) {
          // Handle error message
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
            // Clear the message after showing
            context.read<HomeCubit>().clearMessages();
          }

          // Handle success message
          if (state.successMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage!),
                backgroundColor: colors.green,
                duration: const Duration(seconds: 2),
              ),
            );
            // Clear the message after showing
            context.read<HomeCubit>().clearMessages();
          }
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: _buildAppBar(state),
            extendBodyBehindAppBar: true,
            backgroundColor: colors.surfaceLow,
            body: _buildBody(context, state, colors),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(HomeState state) {
    final userName = state is HomeLoaded ? state.userName : 'Guest';
    final userLocation = state is HomeLoaded ? state.userLocation : null;

    return HomeAppBar(
      userName: userName,
      location: userLocation,
      onNotificationTap: () {
        // TODO: Navigate to notifications
      },
    );
  }

  Widget _buildBody(BuildContext context, HomeState state, dynamic colors) {
    return switch (state) {
      HomeLoading() => const Center(
        child: CircularProgressIndicator(),
      ),
      HomeLoaded() => _buildLoadedContent(context, colors),
      HomeError() => _buildErrorContent(context, state.message, colors),
    };
  }

  Widget _buildLoadedContent(BuildContext context, dynamic colors) {
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
              await context.read<HomeCubit>().initializeHome();
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

  Widget _buildErrorContent(
      BuildContext context, String message, dynamic colors) {
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
              'Oops! Something went wrong',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                context.read<HomeCubit>().initializeHome();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSearchBarSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: SearchBarWithFilter(
          onFilterIconClicked: () {
            context.read<HomeCubit>().handleFilterClick();
          },
          onTextSubmitted: (text) {
            context.read<HomeCubit>().searchProducts(text);
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSpecialOffersSection() {
    return SliverToBoxAdapter(
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) {
          if (previous is HomeLoaded && current is HomeLoaded) {
            return previous.specialOffers != current.specialOffers ||
                previous.currentOfferPage != current.currentOfferPage ||
                previous.isOffersLoading != current.isOffersLoading;
          }
          return true;
        },
        builder: (context, state) {
          if (state is! HomeLoaded) return const SizedBox.shrink();

          if (state.isOffersLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state.specialOffers.isEmpty) {
            return const SizedBox.shrink();
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
            child: SpecialOffersSection(
              offers: state.specialOffers,
              currentPage: state.currentOfferPage,
              onPageChanged: (page) {
                context.read<HomeCubit>().updateOfferPage(page);
              },
              onOfferTap: (offerId) {
                context.read<HomeCubit>().handleOfferTap(offerId);
              },
            ),
          );
        },
      ),
    );
  }

  SliverToBoxAdapter _buildTopStoresSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) {
          if (previous is HomeLoaded && current is HomeLoaded) {
            return previous.topStores != current.topStores ||
                previous.favoriteStoreIds != current.favoriteStoreIds ||
                previous.isStoresLoading != current.isStoresLoading;
          }
          return true;
        },
        builder: (context, state) {
          if (state is! HomeLoaded) return const SizedBox.shrink();

          if (state.isStoresLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state.topStores.isEmpty) {
            return const SizedBox.shrink();
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
            child: TopStoresSection(
              topStores: state.topStores,
              favoriteStoreIds: state.favoriteStoreIds,
              onLikePressed: (storeId) {
                context.read<HomeCubit>().toggleStoreFavorite(storeId);
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
      ),
    );
  }
}