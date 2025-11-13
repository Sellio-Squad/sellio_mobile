import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/app_management/route/navigation_extensions.dart';
import '../../../../core/app_management/route/route_args.dart';
import '../../../../core/design_system/constants/assets.dart';
import '../../../../core/design_system/widgets/cards/product_vertical_card.dart';
import '../../../../core/design_system/widgets/section_header.dart';
import '../../../../domain/entities/product.dart';

class ProductsSection extends StatelessWidget {
  final List<Product> products;
  final String? searchQuery;
  final Map<String, int> productCounts;
  final Set<String> favoriteProductIds;
  final Function(String) onIncrement;
  final Function(String) onDecrement;
  final Function(String) onFavorite;

  const ProductsSection({
    super.key,
    required this.products,
    this.searchQuery,
    required this.productCounts,
    required this.favoriteProductIds,
    required this.onIncrement,
    required this.onDecrement,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SectionHeader(
            title: searchQuery == null ? 'Trending Products' : 'Search Results',
            trailing: SvgPicture.asset(Assets.arrowRight, width: 20, height: 20),
          ),
        ),
        products.isEmpty ? _buildEmptyState(context) : _buildProductsList(),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return SizedBox(
      height: 272,
      child: Center(
        child: Text(
          searchQuery == null
              ? 'No products available'
              : 'No products found for "$searchQuery"',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildProductsList() {
    return SizedBox(
      height: 272,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final product = products[index];
          final count = productCounts[product.id] ?? 0;
          final isFavorite = favoriteProductIds.contains(product.id);

          return GestureDetector(
            onTap: () => context.navigator.pushProductDetails(
              ProductDetailsArgs(
                productCount: count,
                productDescription: product.description,
                productPrice: product.price,
                // productPriceBeforeDiscount: product.priceBeforeDiscount,
              )
            ),
            child: SizedBox(
              width: 160,
              child: ProductVerticalCard(
                imageUrl: product.images.isNotEmpty
                    ? product.images.first
                    : 'assets/images/product_3.webp',
                title: product.name,
                price: '\$${product.price.toStringAsFixed(2)}',
                count: count,
                isFavorite: isFavorite,
                onIncrement: () => onIncrement(product.id),
                onDecrement: () => onDecrement(product.id),
                onFavorite: () => onFavorite(product.id),
              ),
            ),
          );
        },
      ),
    );
  }
}