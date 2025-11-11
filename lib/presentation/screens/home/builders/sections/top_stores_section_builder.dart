import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubits/favorites/cubit/favorites_cubit.dart';
import '../../../../cubits/favorites/cubit/favorites_state.dart';
import '../../cubits/stores/cubit/home_top_stores_cubit.dart';
import '../../cubits/stores/cubit/home_top_stores_state.dart';
import '../../utils/home_navigation.dart';
import '../../widgets/top_stores_section.dart';

Widget buildTopStoresSection() {
  return BlocBuilder<HomeTopStoresCubit, HomeTopStoresState>(
    builder: (context, storesState) {
      if (storesState is HomeTopStoresLoading) {
        return const SliverToBoxAdapter(child: _LoadingWidget());
      }

      if (storesState is! HomeTopStoresLoaded || storesState.stores.isEmpty) {
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      }

      return BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, favState) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
              child: TopStoresSection(
                stores: storesState.stores,
                favoriteStoreIds: favState.storeIds,
                onLikePressed: (storeId) {
                  context.read<FavoritesCubit>().toggleStoreFavorite(storeId);
                },
                onStorePressed: (store) {
                  navigateToStoreDetails(context, store);
                },
              ),
            ),
          );
        },
      );
    },
  );
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