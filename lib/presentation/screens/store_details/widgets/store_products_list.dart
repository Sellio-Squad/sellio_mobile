import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/localization/localization_service.dart';
import '../../../../core/design_system/widgets/cards/productHorizontalCard.dart';
import '../../../../../../domain/entities/product.dart';

class StoreProductsList extends StatefulWidget {
  final int categoryIndex;
  final List<Product> products;
  final List<String> categories;

  const StoreProductsList({
    super.key,
    required this.categoryIndex,
    required this.products,
    required this.categories,
  });

  @override
  State<StoreProductsList> createState() => _StoreProductsListState();
}

class _StoreProductsListState extends State<StoreProductsList> {
  static const double _itemSpacing = 12.0;

  final Map<String, int> _productCounts = {};

  List<Product> get filteredProducts {
    if (widget.categories.isEmpty || widget.categoryIndex >= widget.categories.length) {
      return widget.products;
    }
    final selectedCategoryId = widget.categories[widget.categoryIndex];
    return widget.products.where((p) => p.categoryId == selectedCategoryId).toList();
  }

  int _getProductCount(String productId) => _productCounts[productId] ?? 0;

  void _incrementCount(String productId) {
    setState(() => _productCounts[productId] = _getProductCount(productId) + 1);
  }

  void _decrementCount(String productId) {
    setState(() {
      final count = _getProductCount(productId);
      if (count > 0) _productCounts[productId] = count - 1;
    });
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
          return Padding(
            padding: const EdgeInsets.only(bottom: _itemSpacing),
            child: ProductHorizontalCard(
              imageUrl: product.images.isNotEmpty ? product.images.first : '',
              title: product.name,
              description: product.description,
              price: product.price.toString(),
              count: _getProductCount(product.id),
              onIncrement: () => _incrementCount(product.id),
              onDecrement: () => _decrementCount(product.id),
            ),
          );
        },
        childCount: filteredProducts.length,
      ),
    );
  }
}
