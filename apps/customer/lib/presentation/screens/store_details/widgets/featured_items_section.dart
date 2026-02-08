import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/core/navigate/navigation_extensions.dart';
import 'package:sellio_mobile/presentation/cubits/favorites/cubit/favorites_cubit.dart';
import 'package:sellio_mobile/presentation/cubits/favorites/cubit/favorites_state.dart';
import 'package:design_system/design_system.dart';
import '../../../../core/navigate/route_args.dart';
import '../../../../domain/entities/product.dart';
import '../../../cubits/cart/cubit/cart_cubit.dart';
import '../../../cubits/cart/cubit/cart_state.dart';

class FeaturedItemsSection extends StatefulWidget {
  final List<Product> products;

  const FeaturedItemsSection({super.key, required this.products});

  @override
  State<FeaturedItemsSection> createState() => _FeaturedItemsSectionState();
}

class _FeaturedItemsSectionState extends State<FeaturedItemsSection> {
  @override
  Widget build(BuildContext context) {
    if (widget.products.isEmpty) return const SizedBox.shrink();

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
            ),
          ),
        ),
        SizedBox(
          height: 210,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: widget.products.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final product = widget.products[index];

              return GestureDetector(
                onTap: () => context.navigator.pushProductDetails(
                  ProductDetailsArgs(
                    productId: product.id,
                  ),
                ),
                child: SizedBox(
                  width: 160,
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (BuildContext context, cartState) {
                      return BlocBuilder<FavoritesCubit, FavoritesState>(
                        builder: (BuildContext context, favState) {
                          final isFavorite = favState.productIds.contains(product.id);
                          return SellioProductVerticalCard(
                            productId: product.id,
                            imageUrl: product.images.isNotEmpty
                                ? product.images.first
                                : AppImages.cartProduct,
                            title: product.title,
                            price: '\$${product.price}',
                            isFavorite: isFavorite,
                            onFavoriteToggle: () async {
                              // Pessimistic update: wait for API response before updating UI
                              final success = await context
                                  .read<FavoritesCubit>()
                                  .toggleProductFavorite(product.id);
                              return success;
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
