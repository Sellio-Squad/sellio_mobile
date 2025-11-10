import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubits/cart/cubit/cart_cubit.dart';
import '../../../../cubits/cart/cubit/cart_state.dart';
import '../../../../cubits/favorites/cubit/favorites_cubit.dart';
import '../../../../cubits/favorites/cubit/favorites_state.dart';

import '../../cubits/products/cubit/home_trending_products_cubit.dart';
import '../../cubits/products/cubit/home_trending_products_state.dart';
import '../../widgets/products_section.dart';

Widget buildProductsSection() {
  return BlocBuilder<HomeTrendingProductsCubit, HomeTrendingProductsState>(
    builder: (context, productsState) {
      if (productsState is HomeTrendingProductsLoading || productsState is HomeTrendingProductsSearching) {
        return const SliverToBoxAdapter(
          child: SizedBox(
            height: 272,
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      }

      if (productsState is! HomeTrendingProductsLoaded) {
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      }

      return BlocBuilder<CartCubit, CartState>(
        builder: (context, cartState) {
          return BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, favState) {
              return SliverToBoxAdapter(
                child: ProductsSection(
                  products: productsState.products,
                  searchQuery: productsState.searchQuery,
                  productCounts: cartState.productCounts,
                  favoriteProductIds: favState.productIds,
                  onIncrement: (productId) =>
                      context.read<CartCubit>().incrementProduct(productId),
                  onDecrement: (productId) =>
                      context.read<CartCubit>().decrementProduct(productId),
                  onFavorite: (productId) => context
                      .read<FavoritesCubit>()
                      .toggleProductFavorite(productId),
                ),
              );
            },
          );
        },
      );
    },
  );
}