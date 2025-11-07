import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/design_system/constants/assets.dart';
import '../../../../core/design_system/widgets/cards/product_vertical_card.dart';
import '../../../../core/design_system/widgets/section_header.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        if (previous is HomeLoaded && current is HomeLoaded) {
          return previous.trendingProducts != current.trendingProducts ||
              previous.productCounts != current.productCounts ||
              previous.favoriteProductIds != current.favoriteProductIds ||
              previous.isProductsLoading != current.isProductsLoading ||
              previous.searchQuery != current.searchQuery;
        }
        return true;
      },
      builder: (context, state) {
        if (state is! HomeLoaded) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SectionHeader(
                  title: state.searchQuery.isEmpty
                      ? 'Trending Products'
                      : 'Search Results',
                  trailing: SvgPicture.asset(
                    Assets.arrowRight,
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
              if (state.isProductsLoading)
                const SizedBox(
                  height: 272,
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state.trendingProducts.isEmpty)
                SizedBox(
                  height: 272,
                  child: Center(
                    child: Text(
                      state.searchQuery.isEmpty
                          ? 'No products available'
                          : 'No products found for "${state.searchQuery}"',
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
                    itemCount: state.trendingProducts.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final product = state.trendingProducts[index];
                      final count = state.productCounts[product.id] ?? 0;
                      final isFavorite =
                      state.favoriteProductIds.contains(product.id);

                      return SizedBox(
                        width: 160,
                        child: ProductVerticalCard(
                          imageUrl: product.images.isNotEmpty
                              ? product.images.first
                              : 'assets/images/product_3.webp',
                          title: product.name,
                          price: '\$${product.price.toStringAsFixed(2)}',
                          count: count,
                          isFavorite: isFavorite,
                          onIncrement: () {
                            context
                                .read<HomeCubit>()
                                .incrementProduct(product.id);
                          },
                          onDecrement: () {
                            context
                                .read<HomeCubit>()
                                .decrementProduct(product.id);
                          },
                          onFavorite: () {
                            context
                                .read<HomeCubit>()
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
  }
}