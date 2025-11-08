import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/design_system/constants/assets.dart';
import '../../../../core/design_system/widgets/cards/product_vertical_card.dart';
import '../../../../core/design_system/widgets/section_header.dart';
import '../../../features/cart/cubit/cart_cubit.dart';
import '../../../features/cart/cubit/cart_state.dart';
import '../../../features/favorites/cubit/favorites_cubit.dart';
import '../../../features/favorites/cubit/favorites_state.dart';
import '../../../features/products/cubit/products_cubit.dart';
import '../../../features/products/cubit/products_state.dart';


class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, productsState) {
          if (productsState is ProductsLoading || productsState is ProductsSearching) {
            return const SliverToBoxAdapter(
              child: SizedBox(
                height: 272,
                child: Center(child: CircularProgressIndicator()),
              ),
            );
          }

          if (productsState is! ProductsLoaded) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }

          return BlocBuilder<CartCubit, CartState>(
            builder: (context, cartState) {
              return BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, favState) {
                  return SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SectionHeader(
                            title: productsState.searchQuery == null
                                ? 'Trending Products'
                                : 'Search Results',
                            trailing: SvgPicture.asset(
                              Assets.arrowRight,
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                        if (productsState.products.isEmpty)
                          SizedBox(
                            height: 272,
                            child: Center(
                              child: Text(
                                productsState.searchQuery == null
                                    ? 'No products available'
                                    : 'No products found for "${productsState.searchQuery}"',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          )
                        else
                          SizedBox(
                            height: 272,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: productsState.products.length,
                              separatorBuilder: (_, __) =>
                              const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                final product = productsState.products[index];
                                final count =
                                    cartState.productCounts[product.id] ?? 0;
                                final isFavorite =
                                favState.productIds.contains(product.id);

                                return SizedBox(
                                  width: 160,
                                  child: ProductVerticalCard(
                                    imageUrl: product.images.isNotEmpty
                                        ? product.images.first
                                        : 'assets/images/product_3.webp',
                                    title: product.name,
                                    price:
                                    '\$${product.price.toStringAsFixed(2)}',
                                    count: count,
                                    isFavorite: isFavorite,
                                    onIncrement: () {
                                      context
                                          .read<CartCubit>()
                                          .incrementProduct(product.id);
                                    },
                                    onDecrement: () {
                                      context
                                          .read<CartCubit>()
                                          .decrementProduct(product.id);
                                    },
                                    onFavorite: () {
                                      context
                                          .read<FavoritesCubit>()
                                          .toggleProductFavorite(product.id);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
    );
  }
}
