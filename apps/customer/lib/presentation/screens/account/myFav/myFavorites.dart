import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/presentation/cubits/favorites/cubit/favorites_cubit.dart';
import 'package:sellio_mobile/presentation/cubits/favorites/cubit/favorites_state.dart';
import 'package:sellio_mobile/presentation/screens/account/myFav/widgets/empty_favorites_state.dart';

import '../../../../core/utils/snackbar_helper.dart';
import 'widgets/products_grid_section.dart';
import 'widgets/stores_section.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _selectedTabIndex = 0;

  List<TabInfo> _getTabs(BuildContext context) => [
        TabInfo(context.local.products, AppImages.product),
        TabInfo(context.local.stores, AppImages.store),
      ];

  @override
  void initState() {
    super.initState();
    // Load favorites when screen opens
    _loadFavorites();
  }

  void _loadFavorites() {
    context.read<FavoritesCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colorScheme = theme.colors;
    final tabs = _getTabs(context);

    return BlocListener<FavoritesCubit, FavoritesState>(
      listener: (context, state) {
        // listen for error
        if (state is FavoritesError) {
          SnackBarHelper.showError(context, state.message);
        }
      },
      child: Scaffold(
        backgroundColor: colorScheme.surfaceLow,
        appBar: SellioAppBar(
          title: context.local.favorites,
          showBackButton: true,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _loadFavorites();
          },
          child: SafeArea(
            child: BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, state) {
                return CustomScrollView(
                  slivers: [
                    // Category Tabs
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        child: Row(
                          children: List.generate(tabs.length, (index) {
                            final isSelected = _selectedTabIndex == index;
                            final tab = tabs[index];

                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: SellioChip(
                                label: tab.label,
                                assetIcon: tab.iconAsset,
                                selected: isSelected,
                                onTap: () =>
                                    setState(() => _selectedTabIndex = index),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),

                    // Loading state
                    if (state is FavoritesLoading)
                      const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )

                    // Products or Stores Tab
                    else if (state is FavoritesLoaded)
                      _selectedTabIndex == 0
                          ? ProductsGridSection(
                              products: state.favoriteProducts ?? [],
                              onToggleFavorite: (productId) async =>
                                  await context
                                      .read<FavoritesCubit>()
                                      .toggleProductFavorite(productId, context),
                            )
                          : StoresSection(
                              stores: state.favoriteStores ?? [],
                              onToggleFavorite: (storeId) => context
                                  .read<FavoritesCubit>()
                                  .toggleStoreFavorite(storeId, context),
                            )

                    // Error state
                    else if (state is FavoritesError)
                      const SliverFillRemaining(
                        child: Center(
                          child: EmptyFavoritesWidget(),
                        ),
                      )

                    // Initial state
                    else
                      const SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class TabInfo {
  final String label;
  final String iconAsset;

  const TabInfo(this.label, this.iconAsset);
}
