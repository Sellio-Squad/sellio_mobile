import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import '../../../../../cubits/favorites/cubit/favorites_cubit.dart';
import '../../../../../cubits/favorites/cubit/favorites_state.dart';
import '../../../../../cubits/cart/cubit/cart_cubit.dart';
import '../../../../../cubits/cart/cubit/cart_state.dart';
import '../../../utils/home_navigation.dart';
import '../models/product_summary_ui_model.dart';

class ProductsList extends StatelessWidget {
  final List<ProductSummaryUIModel> products;
  final String? searchQuery;

  const ProductsList({
    super.key,
    required this.products,
    this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SectionHeader(
            title: searchQuery == null
                ? context.local.trending_products
                : context.local.search_results,
            trailing: SvgPicture.asset(
              AppImages.arrowRight,
              width: 20,
              height: 20,
              matchTextDirection: true,
            ),
          ),
        ),
        if (products.isEmpty)
          SizedBox(
            height: 320,
            child: Center(
              child: Text(
                searchQuery == null
                    ? context.local.no_products_available
                    : context.local.no_products_found_for(
                    searchQuery as Object,),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          )
        else
          SizedBox(
            height: 320,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final product = products[index];

                return SizedBox(
                  width: 196,
                  child: _ProductItem(product: product),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _ProductItem extends StatelessWidget {
  final ProductSummaryUIModel product;

  const _ProductItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, favoritesState) {
        bool isFavorite = product.isFavorite;
        if (favoritesState is FavoritesLoaded) {
          isFavorite = favoritesState.favoriteProductIds.contains(product.id);
        }

        return BlocBuilder<CartCubit, CartState>(
          builder: (context, cartState) {
            int count = 0;
            if (cartState is CartLoaded || cartState is CartLoading || cartState is CartError) {
               count = cartState.productCounts[product.id] ?? 0;
            }

            return SellioProductVerticalCard(
              key: ValueKey(product.id),
              productId: product.id,
              imageUrl: product.imageUrl,
              title: product.title,
              price: product.price,
              onTap: () => navigateToProductDetails(context, product.id),
              isFavorite: isFavorite,
              onFavoriteToggle: () {
                context
                    .read<FavoritesCubit>()
                    .toggleFavorite(product.id, FavoriteType.product);
              },
              count: count,
              onAddToCart: () {
                final double parsedPrice = double.tryParse(product.price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
                context.read<CartCubit>().addToCart(
                  productId: product.id,
                  productName: product.title,
                  productImage: product.imageUrl,
                  price: parsedPrice,
                  currency: '\$',
                );
              },
              onIncrement: () => context.read<CartCubit>().incrementProduct(product.id),
              onDecrement: () => context.read<CartCubit>().decrementProduct(product.id),
            );
          },
        );
      },
    );
  }
}