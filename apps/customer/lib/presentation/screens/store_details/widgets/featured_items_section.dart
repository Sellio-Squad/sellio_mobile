import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/core/navigate/navigation_extensions.dart';
import '../../../../core/navigate/route_args.dart';
import '../../../../domain/entities/product.dart';
import '../../../cubits/favorites/cubit/favorites_cubit.dart';
import '../../../cubits/favorites/cubit/favorites_state.dart';

class FeaturedItemsSection extends StatelessWidget {
  final List<Product> products;

  const FeaturedItemsSection({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SectionHeader(
            title: context.local.featured_items,
            trailing: SvgPicture.asset(
              AppImages.arrowRight,
              width: 20,
              height: 20,
              matchTextDirection: true,
            ),
          ),
        ),
        SizedBox(
          height: 210,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: products.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final product = products[index];

              return GestureDetector(
                onTap: () => context.navigator.pushProductDetails(
                  ProductDetailsArgs(productId: product.id),
                ),
                child: SizedBox(
                  width: 160,
                  child: _FeaturedProductCard(product: product),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _FeaturedProductCard extends StatelessWidget {
  final Product product;

  const _FeaturedProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        bool isFavorite = product.isFavorite;

        if (state is FavoritesLoaded) {
          isFavorite = state.favoriteProductIds.contains(product.id);
        }

        return SellioProductVerticalCard(
          productId: product.id,
          imageUrl: product.images.isNotEmpty
              ? product.images.first
              : AppImages.cartProduct,
          title: product.title,
          price: '\$${product.minPrice}',
          isFavorite: isFavorite,
          onFavoriteToggle: () {
            context.read<FavoritesCubit>().toggleFavorite(product.id, FavoriteType.product);
          },
        );
      },
    );
  }
}
