import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubits/favorites/cubit/favorites_cubit.dart';
import '../../../../cubits/favorites/cubit/favorites_state.dart';
import '../../utils/home_navigation.dart';
import 'cubit/home_top_stores_cubit.dart';
import 'cubit/home_top_stores_state.dart';
import 'top_stores_list_shimmer.dart';
import 'widgets/stores_list.dart';

class TopStoresSection extends StatelessWidget {
  const TopStoresSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTopStoresCubit, HomeTopStoresState>(
      listener: (context, state) {
        if (state is HomeTopStoresError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              action: SnackBarAction(
                label: 'Retry',
                textColor: Colors.white,
                onPressed: () {
                  context.read<HomeTopStoresCubit>().refreshStores();
                },
              ),
            ),
          );
        }
      },
      builder: (context, storesState) {
        if (storesState is HomeTopStoresLoading) {
          return const SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: TopStoresShimmer()));
        }

        if (storesState is! HomeTopStoresLoaded || storesState.stores.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        return BlocConsumer<FavoritesCubit, FavoritesState>(
          listener: (context, favState) {
            if (favState is FavoritesError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(favState.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, favState) {
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                child: StoresList(
                  stores: storesState.stores,
                  favoriteStoreIds: favState.storeIds,
                  onLikePressed: (storeId) {
                    context.read<FavoritesCubit>().toggleStoreFavorite(storeId);
                  },
                  onStorePressed: (store) {
                    navigateToStoreDetails(context, store.id);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
