import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/cart/cubit/cart_cubit.dart';
import '../cubits/cart/cubit/cart_state.dart';

class CustomerProductCard extends StatelessWidget {
  final String productId;
  final String imageUrl;
  final String title;
  final String formattedPrice;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteToggle;
  final Key? cardKey;

  const CustomerProductCard({
    super.key,
    this.cardKey,
    required this.productId,
    required this.imageUrl,
    required this.title,
    required this.formattedPrice,
    required this.isFavorite,
    required this.onTap,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) {
        return previous.productCounts[productId] !=
            current.productCounts[productId];
      },
      builder: (context, cartState) {
        final count = cartState.productCounts[productId] ?? 0;

        return SellioProductVerticalCard(
          key: cardKey,
          imageUrl: imageUrl,
          title: title,
          price: formattedPrice,
          isFavorite: isFavorite,
          count: count,
          onIncrement: () {
            context.read<CartCubit>().incrementProduct(
              productId,
            );
          },
          onDecrement: () {
            context.read<CartCubit>().decrementProduct(
              productId,
            );
          },
          onAddToCart: () {
            context.read<CartCubit>().addToCart(
              productId: productId,
              quantity: 1,
            );
          },
          onTap: onTap,
          onFavoriteToggle: onFavoriteToggle,
        );
      },
    );
  }
}