import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import '../../../../../../core/design_system/constants/assets.dart';
import '../../../../../../core/design_system/widgets/cards/sellio_product_vertical_card.dart';
import '../../../../../../core/design_system/widgets/section_header.dart';
import '../models/trending_product_ui_model.dart';

class ProductsList extends StatelessWidget {
  final List<TrendingProductUIModel> products;
  final String? searchQuery;
  final Map<String, int> productCounts;
  final Set<String> favoriteProductIds;
  final Function(String) onIncrement;
  final Function(String) onDecrement;
  final Function(String) onFavorite;

  const ProductsList({
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
            title: searchQuery == null
                ? context.local.trending_products
                : context.local.search_results,
            trailing: SvgPicture.asset(
              Assets.arrowRight,
              width: 20,
              height: 20,
            ),
          ),
        ),
        products.isEmpty
            ? _buildEmptyState(context)
            : _buildProductsList(),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return SizedBox(
      height: 272,
      child: Center(
        child: Text(
          searchQuery == null
              ? context.local.no_products_available
              : context.local.no_products_found_for(searchQuery as Object),
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

          return SizedBox(
            width: 160,
            child: SellioProductVerticalCard(
              imageUrl: product.imageUrl,
              title: product.title,
              price: product.price,
              count: count,
              isFavorite: isFavorite,
              onIncrement: () => onIncrement(product.id),
              onDecrement: () => onDecrement(product.id),
              onFavorite: () => onFavorite(product.id),
            ),
          );
        },
      ),
    );
  }
}