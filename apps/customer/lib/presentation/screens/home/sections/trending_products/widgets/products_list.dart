import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/presentation/screens/home/utils/home_navigation.dart';
import '../models/product_summary_ui_model.dart';

class ProductsList extends StatelessWidget {
  final List<ProductSummaryUIModel> products;
  final String? searchQuery;
  final Future<bool> Function(String) onFavorite;

  const ProductsList({
    super.key,
    required this.products,
    this.searchQuery,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: GestureDetector(
            onTap: () => _navigateToMoreTrending(context),
            child: SectionHeader(
              title: searchQuery == null
                  ? context.local.trending_products
                  : context.local.search_results,
              trailing: SvgPicture.asset(
                AppImages.arrowRight,
                width: 20,
                height: 20,
                matchTextDirection: true,
              ),
            ),
          ),
        ),
        products.isEmpty
            ? _buildEmptyState(context)
            : _buildProductsList(),
      ],
    );
  }

  void _navigateToMoreTrending(BuildContext context) {
    // Only navigate for trending products, not search results
    if (searchQuery == null) {
      context.push('/moreTrending');
    }
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
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final product = products[index];
          print('product list:${product.title}, ${product.imageUrl}');

          return SizedBox(
            width: 160,
            child: SellioProductVerticalCard(
              productId: product.id,
              imageUrl: product.imageUrl,
              title: product.title,
              price: product.price,
              isFavorite: product.isFavorite,
              onFavoriteToggle: () async {
                final success = await onFavorite(product.id);
                return success;
              },
              onTap: () => navigateToProductDetails(context, product.id),
            ),
          );
        },
      ),
    );
  }
}
