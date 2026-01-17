import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import '../../../../../../domain/entities/product.dart';

class StoreProductsList extends StatefulWidget {
  final int categoryIndex;
  final List<Product> products;
  final List<String> categories;
  final VoidCallback? onTap;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final int count;

  const StoreProductsList({
    super.key,
    required this.categoryIndex,
    required this.products,
    required this.categories,
    this.onTap,
    required this.onIncrement,
    required this.onDecrement,
    required this.count,
  });

  @override
  State<StoreProductsList> createState() => _StoreProductsListState();
}

class _StoreProductsListState extends State<StoreProductsList> {
  static const double _itemSpacing = 12.0;

  List<Product> get filteredProducts {
    if (widget.categories.isEmpty || widget.categoryIndex >= widget.categories.length) {
      return widget.products;
    }
    final selectedCategoryId = widget.categories[widget.categoryIndex];
    return widget.products.where((p) => p.categoryId == selectedCategoryId).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (filteredProducts.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Text('No products available'),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          final product = filteredProducts[index];
          return GestureDetector(
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.only(bottom: _itemSpacing),
              child: SellioProductHorizontalCard(
                imageUrl: product.images.isNotEmpty 
                    ? product.images.first 
                    : AppImages.cartProduct,
                title: product.title,
                description: product.description,
                price: product.price.toString(),
                count: widget.count,
                onIncrement: () => widget.onIncrement,
                onDecrement: () => widget.onDecrement,
              ),
            ),
          );
        },
        childCount: filteredProducts.length,
      ),
    );
  }
}
