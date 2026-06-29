import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/l10n/localization_service.dart';
import '../../../cubits/favorites/cubit/favorites_cubit.dart';
import '../../../cubits/favorites/cubit/favorites_state.dart';
import 'widgets/stores_section.dart';
import 'widgets/products_grid_section.dart';
import 'widgets/empty_favorites_state.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _selectedTabIndex = 0;

  List<TabInfo> _getTabs(BuildContext context) => [
        TabInfo(context.local.products),
        TabInfo(context.local.stores),
      ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoritesCubit>().refreshFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colorScheme = theme.colors;
    final tabs = _getTabs(context);

    return BlocListener<FavoritesCubit, FavoritesState>(
      listener: (context, state) {
        if (state is FavoritesActionFailure) {
          SnackBarHelper.showError(
            context,
            state.message,
            title: context.local.error,
          );
        }
      },
      child: Scaffold(
        backgroundColor: colorScheme.surfaceLow,
        appBar: SellioAppBar(
          title: context.local.favorites,
          showBackButton: true,
        ),
        body: SafeArea(
          child: BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              if (state is FavoritesInitial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is! FavoritesLoaded) {
                return const EmptyFavoritesWidget();
              }

              final favoriteProducts = state.favoriteProducts
                  .where((p) => state.favoriteProductIds.contains(p.id))
                  .toList();
              final favoriteStores = state.favoriteStores
                  .where((s) => state.favoriteStoreIds.contains(s.id))
                  .toList();

              return CustomScrollView(
                slivers: [
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

                          return SizedBox(
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: SellioChip(
                                label: tab.label,
                                selected: isSelected,
                                onTap: () =>
                                    setState(() => _selectedTabIndex = index),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  _selectedTabIndex == 0
                      ? ProductsGridSection(
                          products: favoriteProducts,
                          favoriteIds: state.favoriteProductIds,
                        )
                      : StoresSection(
                          stores: favoriteStores,
                          favoriteStoreIds: state.favoriteStoreIds,
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

class TabInfo {
  final String label;
  const TabInfo(this.label);
}
