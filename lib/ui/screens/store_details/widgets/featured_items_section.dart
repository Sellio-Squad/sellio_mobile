import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/widgets/cards/product_vertical_card.dart';
import 'package:sellio_mobile/core/design_system/widgets/section_header.dart';

class FeaturedItemsSection extends StatefulWidget {
  const FeaturedItemsSection({super.key});

  @override
  State<FeaturedItemsSection> createState() => _FeaturedItemsSectionState();
}

class _FeaturedItemsSectionState extends State<FeaturedItemsSection> {
  final Map<int, int> _productCounts = {};

  // Sample featured products - replace with actual data from API
  final List<Map<String, dynamic>> _featuredProducts = [
    {
      'id': 0,
      'imageUrl': 'assets/images/product_1.png',
      'title': 'Birthday cake with bows',
      'price': '\$12.99',
    },
    {
      'id': 1,
      'imageUrl': 'assets/images/product_2.png',
      'title': 'Strawberry Cupcake',
      'price': '\$5.00',
    },
    {
      'id': 2,
      'imageUrl': 'assets/images/product_3.png',
      'title': 'Chocolate Donut',
      'price': '\$3.50',
    },
    {
      'id': 3,
      'imageUrl': 'assets/images/product_1.png',
      'title': 'Vanilla Birthday Cake',
      'price': '\$15.99',
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
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SectionHeader(
              title: 'Featured Items',
              trailing: SvgPicture.asset(
                Assets.arrowRight,
                width: 20,
                height: 20,
              ),
            ),
          ),
          SizedBox(
            height: 272,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _featuredProducts.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final product = _featuredProducts[index];
                final productId = product['id'] as int;
                final count = _productCounts[productId] ?? 0;

                return SizedBox(
                  width: 160,
                  child: ProductVerticalCard(
                    imageUrl: product['imageUrl'],
                    title: product['title'],
                    price: product['price'],
                    count: count,
                    onIncrement: () => _incrementProduct(productId),
                    onDecrement: () => _decrementProduct(productId),
                    onFavorite: () {
                      // todo: Handle favorite action
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}