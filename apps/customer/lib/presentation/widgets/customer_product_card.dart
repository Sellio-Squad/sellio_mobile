import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/design_system.dart';
import '../cubits/cart/cubit/cart_cubit.dart';
import '../cubits/cart/cubit/cart_state.dart';

class CustomerProductCard extends StatelessWidget {
  final String productId;
  final String imageUrl;
  final String title;
  final String formattedPrice;
  final double rawPrice;
  final String currency;
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
    required this.rawPrice,
    required this.currency,
    required this.isFavorite,
    required this.onTap,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cartState) {
        return SellioProductVerticalCard(
          key: cardKey,
          imageUrl: imageUrl,
          title: title,
          price: formattedPrice,
          isFavorite: isFavorite,
          count: cartState.productCounts[productId] ?? 0,
          onIncrement: () =>
              context.read<CartCubit>().incrementProduct(productId),
          onDecrement: () =>
              context.read<CartCubit>().decrementProduct(productId),
          onAddToCart: () {
            context.read<CartCubit>().addToCart(
                  productId: productId,
                  productName: title,
                  productImage: imageUrl,
                  price: rawPrice,
                  currency: currency,
                );
          },
          onTap: onTap,
          onFavoriteToggle: onFavoriteToggle,
        );
      },
    );
  }
}
