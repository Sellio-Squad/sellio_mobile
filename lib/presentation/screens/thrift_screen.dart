import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import 'package:sellio_mobile/core/localization/localization_service.dart';

import '../../core/design_system/constants/assets.dart';
import '../../core/design_system/widgets/cards/sellio_product_vertical_card.dart';
import 'home/widgets/category_tabs.dart';

class ThriftScreen extends StatefulWidget {
  const ThriftScreen({super.key});

  @override
  State<ThriftScreen> createState() => _ThriftScreenState();
}

class _ThriftScreenState extends State<ThriftScreen> {
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return Scaffold(
      backgroundColor: colors.surfaceLow,
      appBar: SellioAppBar(title: context.local.thrift),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CategoryTabs(
              categories: [
                CategoryTabData(
                    id: 'all', name: context.local.all, icon: Assets.allCategories),
                CategoryTabData(
                    id: 'clothes',
                    name: context.local.clothes,
                    icon: Assets.clothes),
                CategoryTabData(
                    id: 'furniture',
                    name: context.local.furniture,
                    icon: Assets.clothes),
                CategoryTabData(
                    id: 'electronics',
                    name: context.local.electronics,
                    icon: Assets.clothes),
                CategoryTabData(
                    id: 'books',
                    name: context.local.books,
                    icon: Assets.clothes),
              ],
              selectedIndex: selectedCategory,
              onCategorySelected: (index) {
                setState(() => selectedCategory = index);
              },
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 8)),
          const GridProductsSection(),
        ],
      ),
    );
  }
}

class GridProductsSection extends StatefulWidget {
  const GridProductsSection({super.key});

  @override
  State<GridProductsSection> createState() => _GridProductsSectionState();
}

class _GridProductsSectionState extends State<GridProductsSection> {
  final Map<int, int> _productCounts = {};
  final Map<int, bool> _favorites = {};

  final List<Map<String, dynamic>> _products = [
    {
      'id': 0,
      'imageUrl': 'assets/images/product_3.webp',
      'title': 'Gold Stainless Steel Sun Charm Necklace',
      'price': '\$5.00',
    },
    {
      'id': 1,
      'imageUrl': 'assets/images/product_3.webp',
      'title': 'Birthday cake with bows',
      'price': '\$12.99',
    },
    {
      'id': 2,
      'imageUrl': 'assets/images/product_3.webp',
      'title': 'Product Name 3',
      'price': '\$30.99',
    },
    {
      'id': 3,
      'imageUrl': 'assets/images/product_3.webp',
      'title': 'Birthday cake with bows',
      'price': '\$12.99',
    },
    {
      'id': 4,
      'imageUrl': 'assets/images/product_3.webp',
      'title': 'Product Name 4',
      'price': '\$30.99',
    },
    {
      'id': 5,
      'imageUrl': 'assets/images/product_3.webp',
      'title': 'Product Name 5',
      'price': '\$25.50',
    },
    {
      'id': 6,
      'imageUrl': 'assets/images/product_3.webp',
      'title': 'Birthday cake with bows',
      'price': '\$12.99',
    },
    {
      'id': 7,
      'imageUrl': 'assets/images/product_3.webp',
      'title': 'Product Name 7',
      'price': '\$30.99',
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

  void _toggleFavorite(int productId) {
    setState(() {
      _favorites[productId] = !(_favorites[productId] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final product = _products[index];
            final productId = product['id'] as int;
            final count = _productCounts[productId] ?? 0;
            final isFavorite = _favorites[productId] ?? false;

            return SellioProductVerticalCard(
              key: ValueKey(productId),
              imageUrl: product['imageUrl'],
              title: product['title'],
              price: product['price'],
              count: count,
              isFavorite: isFavorite,
              onIncrement: () => _incrementProduct(productId),
              onDecrement: () => _decrementProduct(productId),
              onFavorite: () => _toggleFavorite(productId),
            );
          },
          childCount: _products.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 12,
          childAspectRatio: 170 / 272,
        ),
      ),
    );
  }
}
