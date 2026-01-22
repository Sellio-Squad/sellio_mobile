import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/error/result.dart';
import 'package:sellio_mobile/domain/entities/product.dart';
import 'package:sellio_mobile/domain/repositories/product_repository.dart';
import 'package:sellio_mobile/presentation/cubits/cart/cubit/cart_cubit.dart';
import 'package:sellio_mobile/presentation/cubits/cart/cubit/cart_state.dart';

import 'empty_favorites_state.dart';

class ProductsGridSection extends StatelessWidget {
  final List<Product> products;
  final Future<bool> Function(String) onToggleFavorite;

  const ProductsGridSection({
    super.key,
    required this.products,
    required this.onToggleFavorite,
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
      sliver: FutureBuilder<Result<List<Product>>>(
        future: context.read<ProductRepository>().getFavoriteProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(48.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return const SliverToBoxAdapter(
              child: EmptyFavoritesWidget(),
            );
          }

          final result = snapshot.data!;

          if (result is! Success<List<Product>>) {
            return const SliverToBoxAdapter(
              child: EmptyFavoritesWidget(),
            );
          }

          final products = result.data;

          if (products.isEmpty) {
            return const SliverToBoxAdapter(
              child: EmptyFavoritesWidget(),
            );
          }

          return BlocBuilder<CartCubit, CartState>(
            builder: (context, cartState) {
              return SliverGrid(
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
                        // Pessimistic update: wait for API response before updating UI
                        final success = await onToggleFavorite(product.id);
                        return success;
                      },
                      onTap: () {
                        // Navigate to product details
                        // Example: context.push('/product/${product.id}');
                      },
                    );
                  },
                  childCount: products.length,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
