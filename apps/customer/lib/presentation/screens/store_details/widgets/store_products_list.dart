import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import '../../../../../../domain/entities/product.dart';

class StoreProductsList extends StatelessWidget {
  final int categoryIndex;
  final List<Product> products;
  final List<String> categories;
  final void Function(Product) onTap;

  const StoreProductsList({
    super.key,
    required this.categoryIndex,
    required this.products,
    required this.categories,
    required this.onTap,
  });

  List<Product> get filteredProducts {
    if (categories.isEmpty || categoryIndex >= categories.length) {
      return products;
    }
    final selectedCategoryId = categories[categoryIndex];

    return products
        .where((p) => p.subCategoriesIds.contains(selectedCategoryId))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    if (filteredProducts.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(context.local.no_products_available),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final product = filteredProducts[index];
          final imageUrl = product.images.firstOrNull;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: SellioProductHorizontalCard(
              imageUrl: imageUrl ?? AppImages.cartProduct,
              title: product.title,
              description: product.description,
              price: product.minPrice.toString(),
              onTap: () => onTap(product),
            ),
          );
        },
        childCount: filteredProducts.length,
      ),
    );
  }
}
