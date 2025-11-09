import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import '../../core/design_system/widgets/cards/product_vertical_card.dart';
import 'home/widgets/category_tabs.dart';

class ThriftScreen extends StatefulWidget {
  const ThriftScreen({super.key});

  @override
  State<ThriftScreen> createState() => _ThriftScreenState();
}

class _ThriftScreenState extends State<ThriftScreen> {
  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return Scaffold(
      backgroundColor: colors.surfaceLow,
      appBar: const SellioAppBar(title: 'Thrift'),
      body: CustomScrollView(slivers: [
        CategoryTabs(
          categories: const [
            CategoryTabData(
                id: 'all', name: 'All', icon: 'assets/icons/all_icon.svg'),
            CategoryTabData(
                id: 'clothes',
                name: 'Clothes',
                icon: 'assets/icons/clothes_icon.svg'),
            CategoryTabData(
                id: 'furniture',
                name: 'Furniture',
                icon: 'assets/icons/furniture_icon.svg'),
            CategoryTabData(
                id: 'electronics',
                name: 'Electronics',
                icon: 'assets/icons/electronics_icon.svg'),
            CategoryTabData(
                id: 'books',
                name: 'Books',
                icon: 'assets/icons/books_icon.svg'),
          ],
          selectedIndex: 0,
          onCategorySelected: (index) {
            // Handle category selection
          },
        ),
        GridProductsSection()
      ]),
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
  bool _isFavourite = false;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {
        'id': 0,
        'imageUrl': 'assets/images/product_3.webp',
        'title': 'Gold Stainless Steel Sun Charm Necklace',
        'price': '\$5.00',
        'isFavourite': _isFavourite,
      },
      {
        'id': 1,
        'imageUrl': 'assets/images/product_3.webp',
        'title': 'Birthday cake with bows',
        'price': '\$12.99',
        'isFavourite': _isFavourite,
      },
      {
        'id': 3,
        'imageUrl': 'assets/images/product_3.webp',
        'title': 'Product Name 3',
        'price': '\$30.99',
        'isFavourite': _isFavourite,
      },
      {
        'id': 4,
        'imageUrl': 'assets/images/product_3.webp',
        'title': 'Birthday cake with bows',
        'price': '\$12.99',
        'isFavourite': _isFavourite,
      },
      {
        'id': 5,
        'imageUrl': 'assets/images/product_3.webp',
        'title': 'Product Name 3',
        'price': '\$30.99',
        'isFavourite': _isFavourite,
      },
      {
        'id': 6,
        'imageUrl': 'assets/images/product_3.webp',
        'title': 'Product Name 3',
        'price': '\$30.99',
        'isFavourite': _isFavourite,
      },
      {
        'id': 7,
        'imageUrl': 'assets/images/product_3.webp',
        'title': 'Birthday cake with bows',
        'price': '\$12.99',
        'isFavourite': _isFavourite,
      },
      {
        'id': 8,
        'imageUrl': 'assets/images/product_3.webp',
        'title': 'Product Name 3',
        'price': '\$30.99',
        'isFavourite': _isFavourite,
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

    void toggleFavourite(int productId) {
      setState(() {
        _isFavourite = !_isFavourite;
      });
    }

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 12,
              childAspectRatio: 170 / 272,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              final productId = product['id'] as int;
              final count = _productCounts[productId] ?? 0;

              return ProductVerticalCard(
                imageUrl: product['imageUrl'],
                title: product['title'],
                price: product['price'],
                count: count,
                isFavorite: product['isFavourite'],
                onIncrement: () => incrementProduct(productId),
                onDecrement: () => decrementProduct(productId),
                onFavorite: () => toggleFavourite(productId),
              );
            },
          ),
        ],
      ),
    );
  }
}
