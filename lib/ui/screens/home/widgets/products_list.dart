import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/design_system/constants/assets.dart';
import '../../../../core/design_system/widgets/cards/product_vertical_card.dart';
import '../../../../core/design_system/widgets/section_header.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  final Map<int, int> _productCounts = {};

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = List.generate(
      4,
          (index) => {
        'id': index,
        'imageUrl': 'https://picsum.photos/152/145?random=$index',
        'title': 'Product Name ${index + 1}',
        'price': '\$${(index + 1) * 10}.99',
      },
    );

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
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added ${product['title']} to favorites'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
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
