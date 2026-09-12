import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/l10n/localization_service.dart';
import '../../../core/navigate/navigation_extensions.dart';
import '../../../core/navigate/route_args.dart';
import '../../../domain/entities/store.dart';
import '../../../domain/repository/store_repository.dart';
import '../../cubits/favorites/cubit/favorites_cubit.dart';
import '../../cubits/favorites/cubit/favorites_state.dart';
import 'cubit/stores_cubit.dart';
import 'cubit/stores_state.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({super.key});

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  late final StoresCubit cubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    cubit = StoresCubit(
      context.read<StoreRepository>(),
    );

    cubit.loadStores();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      cubit.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: context.theme.colors.surfaceLow,
        appBar: SellioAppBar(
          title: context.local.stores,
          showBackButton: true,
        ),
        body: _StoresContent(
          scrollController: _scrollController,
        ),
      ),
    );
  }
}

class _StoresContent extends StatelessWidget {
  final ScrollController scrollController;

  const _StoresContent({
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoresCubit, StoresState>(
      builder: (context, state) {
        if (state.isLoading && state.stores.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.stores.isEmpty && state.errorMessage != null) {
          return Center(
            child: Text(
              context.local.failed_to_load,
              style: context.theme.typography.textTheme.bodyMedium,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () {
            return context.read<StoresCubit>().refresh();
          },
          child: CustomScrollView(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              if (state.stores.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      context.local.no_stores_available,
                      style: context.theme.typography.textTheme.bodyMedium,
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  sliver: SliverList.builder(
                    itemCount: state.stores.length,
                    itemBuilder: (context, index) {
                      return _buildStoreItem(
                        context,
                        state.stores[index],
                      );
                    },
                  ),
                ),
              if (state.isLoadingMore)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStoreItem(BuildContext context, Store store) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, favoritesState) {
        final isFavorite = _isFavorite(store.id, favoritesState);

        return SellioStoreCard(
          imageUrl: store.coverImage,
          title: store.name,
          discountText: store.sale,
          isFavorite: isFavorite,
          onLikePressed: () {
            context
                .read<FavoritesCubit>()
                .toggleFavorite(store.id, FavoriteType.store);
          },
          onCardPressed: () => _navigateToStoreDetails(context, store.id),
        );
      },
    );
  }

  bool _isFavorite(String storeId, FavoritesState favoritesState) {
    if (favoritesState is! FavoritesLoaded) {
      return false;
    }

    return favoritesState.favoriteStoreIds.contains(storeId);
  }

  void _navigateToStoreDetails(BuildContext context, String storeId) {
    context.navigator.pushStoreDetails(StoreDetailsArgs(storeId: storeId));
  }
}
