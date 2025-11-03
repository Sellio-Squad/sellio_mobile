import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/widgets/cards/product_vertical_card.dart';
import '../models/favorite_product_model.dart';
import 'empty_favorites_state.dart';

class ProductsGridSection extends StatelessWidget {
  final List<FavoriteProduct> favoriteProducts;
  final Map<int, int> productCounts;
  final void Function(int) onIncrement;
  final void Function(int) onDecrement;
  final void Function(int) onToggleFavorite;

  const ProductsGridSection({
    super.key,
    required this.favoriteProducts,
    required this.productCounts,
    required this.onIncrement,
    required this.onDecrement,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final items = favoriteProducts.where((p) => p.isFavorite).toList();
    if (items.isEmpty) {
      return const SliverToBoxAdapter(child: EmptyFavoritesWidget());
    }

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.68,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final product = items[index];
            final count = productCounts[product.id] ?? 0;
            return ProductVerticalCard(
              imageUrl: product.imageUrl,
              title: product.title,
              price: product.price,
              count: count,
              onIncrement: () => onIncrement(product.id),
              onDecrement: () => onDecrement(product.id),
              onFavorite: () => onToggleFavorite(product.id),
            );
          },
          childCount: items.length,
        ),
      ),
    );
  }
}
