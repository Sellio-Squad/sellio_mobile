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
        // Repositories will be null for now (using mock data)
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
        // Show error snackbar
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
          context.read<HomeCubit>().clearMessages();
        }

        // Show success snackbar
        if (state.successMessage != null) {

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.successMessage!),
              backgroundColor: colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
          context.read<HomeCubit>().clearMessages();
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: HomeAppBar(
              userName: state.userName,
              location: state.userLocation,
              onNotificationTap: () {
                // TODO: Navigate to notifications
              },
            ),
            extendBodyBehindAppBar: true,
            backgroundColor: colors.surfaceLow,
            body: state.isInitialLoading
                ? const Center(child: CircularProgressIndicator())
                : Stack(
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
                        colors.primary.withOpacity(0),
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
            ),
          ),
        );
      },
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
        buildWhen: (previous, current) =>
        previous.specialOffers != current.specialOffers ||
            previous.currentOfferPage != current.currentOfferPage ||
            previous.isOffersLoading != current.isOffersLoading,
        builder: (context, state) {
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
        buildWhen: (previous, current) =>
        previous.topStores != current.topStores ||
            previous.favoriteStoreIds != current.favoriteStoreIds ||
            previous.isStoresLoading != current.isStoresLoading,
        builder: (context, state) {
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