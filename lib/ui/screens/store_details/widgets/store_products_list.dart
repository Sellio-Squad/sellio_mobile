import 'package:flutter/material.dart';

import '../../../../core/design_system/widgets/cards/productHorizontalCard.dart';

class StoreProductsList extends StatefulWidget {
  final int categoryIndex;

  const StoreProductsList({
    super.key,
    required this.categoryIndex,
  });

  @override
  State<StoreProductsList> createState() => _StoreProductsListState();
}

class _StoreProductsListState extends State<StoreProductsList> {
  final Map<int, int> _productCounts = {};

  // Sample data - replace with actual data from API
  final List<Map<String, dynamic>> _products = [
    {
      'id': 0,
      'imageUrl': 'assets/images/product_1.png',
      'title': 'Birthday cake with bows',
      'description': 'Chocolate cake with vanilla frosting and decorative bows',
      'price': '\$12.99',
      'originalPrice': '\$15.99',
    },
    {
      'id': 1,
      'imageUrl': 'assets/images/product_2.png',
      'title': 'Strawberry Cupcake',
      'description': 'Fresh strawberry cupcake with cream cheese frosting',
      'price': '\$5.00',
      'originalPrice': null,
    },
    {
      'id': 2,
      'imageUrl': 'assets/images/product_3.png',
      'title': 'Chocolate Donut',
      'description': 'Classic chocolate donut with sprinkles',
      'price': '\$3.50',
      'originalPrice': '\$4.00',
    },
  ];

  void _incrementProduct(int productId) {
    setState(() {
      _productCounts[productId] = (_productCounts[productId] ?? 0) + 1;
    });
  }

  void _decrementProduct(int productId) {
    setState(() {
      final count = _productCounts[productId] ?? 0;
      if (count > 0) {
        _productCounts[productId] = count - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final product = _products[index];
            final productId = product['id'] as int;
            final count = _productCounts[productId] ?? 0;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ProductHorizontalCard(
                imageUrl: product['imageUrl'],
                title: product['title'],
                description: product['description'],
                price: product['price'],
                originalPrice: product['originalPrice'],
                count: count,
                onIncrement: () => _incrementProduct(productId),
                onDecrement: () => _decrementProduct(productId),
              ),
            );
          },
          childCount: _products.length,
        ),
      ),
    );
  }
}