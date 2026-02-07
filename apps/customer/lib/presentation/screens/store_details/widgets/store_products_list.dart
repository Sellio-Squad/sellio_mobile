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
    return products.where((p) => p.categoryId == selectedCategoryId).toList();
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

          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: SellioProductHorizontalCard(
              imageUrl: product.images.isNotEmpty
                  ? product.images.first
                  : AppImages.cartProduct,
              title: product.title,
              description: product.description,
              price: product.price.toString(),
              onTap: () => onTap(product),
            ),
          );
        },
        childCount: filteredProducts.length,
      ),
    );
  }
}