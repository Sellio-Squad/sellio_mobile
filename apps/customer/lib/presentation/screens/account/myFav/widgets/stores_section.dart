import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/error/result.dart';
import 'package:sellio_mobile/domain/entities/store.dart';
import 'package:sellio_mobile/domain/repositories/store_repository.dart';
import 'empty_favorites_state.dart';

class StoresSection extends StatelessWidget {
  final List<String> favoriteStoreIds;
  final void Function(String) onToggleFavorite;

  const StoresSection({
    super.key,
    required this.favoriteStoreIds,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    if (favoriteStoreIds.isEmpty) {
      return const SliverToBoxAdapter(
        child: EmptyFavoritesWidget(),
      );
    }

    return SliverToBoxAdapter(
      child: FutureBuilder<Result<List<Store>>>(
        future: context.read<StoreRepository>().getFavoriteStores(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(48.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const EmptyFavoritesWidget();
          }

          final result = snapshot.data!;

          if (result is! Success<List<Store>>) {
            return const EmptyFavoritesWidget();
          }

          final stores = result.data;

          if (stores.isEmpty) {
            return const EmptyFavoritesWidget();
          }

          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stores.length,
              itemBuilder: (context, index) {
                final store = stores[index];

                return SellioStoreCard(
                  imageUrl: store.coverImage,
                  title: store.name,
                  discountText: store.sale,
                  isFavorite: true,
                  onLikePressed: () => onToggleFavorite(store.id),
                  onCardPressed: () {
                    // Navigate to store details
                    // Example: context.push('/store/${store.id}');
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}