import 'package:flutter/material.dart';
import '../../../../../domain/entities/store.dart';
import '../../../home/widgets/top_stores_section.dart';
import 'empty_favorites_state.dart';

class StoresSection extends StatelessWidget {
  final List<Store> stores;
  final void Function(int) onToggleFavorite;

  const StoresSection({
    super.key,
    required this.stores,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final favoriteStores = stores.where((store) => store.isFavorite).toList();

    if (favoriteStores.isEmpty) {
      return const SliverToBoxAdapter(
        child: EmptyFavoritesWidget(),
      );
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: TopStoresSection(
          stores: favoriteStores,
          favoriteStoreIds: favoriteStores.map((store) => store.id.toString()).toSet(),
          onLikePressed: (storeId) => onToggleFavorite(int.parse(storeId)),
          onStorePressed: (store) => {},
        ),
      ),
    );
  }
}
