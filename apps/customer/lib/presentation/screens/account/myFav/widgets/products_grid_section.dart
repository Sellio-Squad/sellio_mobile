import 'package:design_system/widgets/cards/sellio_product_vertical_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/entities/product.dart';
import '../../../../cubits/favorites/cubit/favorites_cubit.dart';
import 'empty_favorites_state.dart';

class ProductsGridSection extends StatelessWidget {
  final List<Product> products;

  const ProductsGridSection({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const SliverToBoxAdapter(
        child: EmptyFavoritesWidget(),
      );
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
            final product = products[index];

            return SellioProductVerticalCard(
              productId: product.id,
              imageUrl:
              product.images.isNotEmpty ? product.images.first : '',
              title: product.title,
              price:
              '${product.currency}${product.price.toStringAsFixed(2)}',
              isFavorite: true,
              onFavoriteToggle: () async {
                context
                    .read<FavoritesCubit>()
                    .toggleFavorite(product.id, FavoriteType.product);
                return;
              },
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
