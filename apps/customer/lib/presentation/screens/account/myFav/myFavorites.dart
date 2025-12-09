import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:design_system/design_system.dart';
import 'models/favorite_product_model.dart';
import 'models/favorite_store_model.dart';
import 'package:sellio_mobile/presentation/cubits/favorites/cubit/favorites_cubit.dart';
import 'package:sellio_mobile/presentation/cubits/favorites/cubit/favorites_state.dart';
import 'widgets/products_grid_section.dart';
import 'widgets/stores_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ['Products', 'Stores'];

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

    return Scaffold(
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
                        children: List.generate(_tabs.length, (index) {
                          final isSelected = _selectedTabIndex == index;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: SellioChip(
                              label: _tabs[index],
                              assetIcon: index == 0
                                  ? AppImages.product
                                  : AppImages.store,
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
                            favoriteProductIds: state.productIds.toList(),
                            onToggleFavorite: (productId) {
                              context
                                  .read<FavoritesCubit>()
                                  .toggleProductFavorite(productId);
                            },
                          )
                        : StoresSection(
                            favoriteStoreIds: state.storeIds.toList(),
                            onToggleFavorite: (storeId) {
                              context
                                  .read<FavoritesCubit>()
                                  .toggleStoreFavorite(storeId);
                            },
                          )

                  // Error state
                  else if (state is FavoritesError)
                    SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: colorScheme.hint,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: theme.typography.textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _loadFavorites,
                              child: Text(context.local.retry),
                            ),
                          ],
                        ),
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
    );
  }
}
