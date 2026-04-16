import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/navigate/navigation_extensions.dart';
import 'package:sellio_mobile/core/navigate/route_args.dart';
import 'package:sellio_mobile/domain/entities/store.dart';
import '../../../../cubits/favorites/cubit/favorites_cubit.dart';
import 'empty_favorites_state.dart';

class StoresSection extends StatelessWidget {
  final List<Store> stores;
  final Set<String> favoriteStoreIds;

  const StoresSection({
    super.key,
    required this.stores,
    required this.favoriteStoreIds,
  });

  @override
  Widget build(BuildContext context) {
    if (stores.isEmpty) {
      return const SliverToBoxAdapter(
        child: EmptyFavoritesWidget(),
      );
    }

    return SliverToBoxAdapter(
      child: ListView.separated(
        padding: const EdgeInsets.only(top: 16),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: stores.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final store = stores[index];

          final isFavorite = favoriteStoreIds.contains(store.id);

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
            onCardPressed: () {
              context.navigator
                  .pushStoreDetails(StoreDetailsArgs(storeId: store.id));
            },
          );
        },
      ),
    );
  }
}
