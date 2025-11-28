import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_list_shimmer.dart';
import '../../../../cubits/cart/cubit/cart_cubit.dart';
import '../../../../cubits/cart/cubit/cart_state.dart';
import '../../../../cubits/favorites/cubit/favorites_cubit.dart';
import '../../../../cubits/favorites/cubit/favorites_state.dart';
import 'cubit/home_trending_products_cubit.dart';
import 'cubit/home_trending_products_state.dart';
import 'widgets/products_list.dart';

class TrendingProductsSection extends StatelessWidget {
  const TrendingProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTrendingProductsCubit, HomeTrendingProductsState>(
      listener: (context, state) {
        if (state is HomeTrendingProductsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }

        if (state is HomeTrendingProductsSearching) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Searching for "${state.query}"...'),
              duration: const Duration(seconds: 1),
              backgroundColor: Colors.blue,
            ),
          );
        }
      },
      builder: (context, productsState) {
        if (productsState is HomeTrendingProductsLoading ||
            productsState is HomeTrendingProductsSearching) {
          return const SliverToBoxAdapter(
            child: ProductsListShimmer(),
          );
        }

        if (productsState is HomeTrendingProductsError) {
          return SliverToBoxAdapter(
            child: _ErrorWidget(
              message: productsState.message,
              onRetry: () {
                context.read<HomeTrendingProductsCubit>().refreshProducts();
              },
            ),
          );
        }

        if (productsState is! HomeTrendingProductsLoaded) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        return BlocConsumer<CartCubit, CartState>(
          listener: (context, cartState) {
            if (cartState is CartError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(cartState.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, cartState) {
            return BlocConsumer<FavoritesCubit, FavoritesState>(
              listener: (context, favState) {
                if (favState is FavoritesError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(favState.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, favState) {
                return SliverToBoxAdapter(
                  child: ProductsList(
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
}

class _ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorWidget({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 272,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}