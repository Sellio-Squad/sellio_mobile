import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/product.dart';
import '../../../../cubits/favorites/cubit/favorites_cubit.dart';
import '../../../../widgets/customer_product_card.dart';
import 'empty_favorites_state.dart';

class ProductsGridSection extends StatelessWidget {
  final List<Product> products;
  final Set<String> favoriteIds;

  const ProductsGridSection({
    super.key,
    required this.products,
    required this.favoriteIds,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const SliverToBoxAdapter(
        child: EmptyFavoritesWidget(),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      sliver: SliverLayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.crossAxisExtent;
          const cardWidth = 170.0;

          final crossAxisCount =
          (screenWidth / cardWidth)
              .floor()
              .clamp(1, 6);

          return SliverGrid(
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 0.72,
              crossAxisSpacing: 8,
              mainAxisSpacing: 12,
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final product = products[index];

                final isFavorite =
                favoriteIds.contains(product.id);

                final imageUrl =
                product.images.isNotEmpty
                    ? product.images.first
                    : '';

                return CustomerProductCard(
                  cardKey: ValueKey(product.id),
                  productId: product.id,
                  imageUrl: imageUrl,
                  title: product.title,
                  formattedPrice:
                  '${product.currency ?? ''}${product.minPrice.toStringAsFixed(2)}',
                  isFavorite: isFavorite,
                  onFavoriteToggle: () async {
                    context
                        .read<FavoritesCubit>()
                        .toggleFavorite(
                      product.id,
                      FavoriteType.product,
                    );
                  },
                  onTap: () {},
                );
              },
              childCount: products.length,
            ),
          );
        },
      ),
    );
  }
}