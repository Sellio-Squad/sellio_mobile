import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/design_system/constants/assets.dart';
import '../../../../core/design_system/widgets/cards/product_vertical_card.dart';
import '../../../../core/design_system/widgets/section_header.dart';

class ProductsSection extends StatefulWidget {
  const ProductsSection({super.key});

  @override
  State<ProductsSection> createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<ProductsSection> {
  final Map<int, int> _productCounts = {};

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {
        'id': 0,
        'imageUrl': 'assets/images/product_1.png',
        'title': 'Gold Stainless Steel Sun Charm Necklace',
        'price': '\$5.00',
      },
      {
        'id': 1,
        'imageUrl': 'assets/images/product_2.png',
        'title': 'Birthday cake with bows',
        'price': '\$12.99',
      },
      {
        'id': 2,
        'imageUrl': 'assets/images/product_3.png',
        'title': 'Product Name 3',
        'price': '\$30.99',
      },
    ];

    void incrementProduct(int productId) {
      setState(() {
        _productCounts[productId] = (_productCounts[productId] ?? 0) + 1;
      });
    }

    void decrementProduct(int productId) {
      setState(() {
        final count = _productCounts[productId] ?? 0;
        if (count > 0) {
          _productCounts[productId] = count - 1;
        }
      });
    }

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SectionHeader(
              title: 'Trending Products',
              trailing: SvgPicture.asset(
                  Assets.arrowRight,
                  width: 20,
                  height: 20
              ),
            ),
          ),
          SizedBox(
            height: 272,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final product = products[index];
                final productId = product['id'] as int;
                final count = _productCounts[productId] ?? 0;

                return SizedBox(
                  width: 160,
                  child: ProductVerticalCard(
                    imageUrl: product['imageUrl'],
                    title: product['title'],
                    price: product['price'],
                    count: count,
                    onIncrement: () => incrementProduct(productId),
                    onDecrement: () => decrementProduct(productId),
                    onFavorite: () {
                      // todo:  Handle favorite action
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