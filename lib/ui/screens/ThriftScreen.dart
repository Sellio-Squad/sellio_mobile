import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/category_tabs.dart';
import '../../core/design_system/widgets/cards/product_vertical_card.dart';

class ThriftScreen extends StatefulWidget {
  const ThriftScreen({super.key});

  @override
  State<ThriftScreen> createState() => _ThriftScreenState();
}

class _ThriftScreenState extends State<ThriftScreen> {
  final List<ThriftItem> thriftItems = [
    ThriftItem(
      imageUrl: 'https://example.com/image1.jpg',
      title: 'Vintage Jacket',
      price: '\$45.00',
    ),
    ThriftItem(
      imageUrl: 'https://example.com/image2.jpg',
      title: 'Retro Sneakers',
      price: '\$60.00',
    ),
    ThriftItem(
      imageUrl: 'https://example.com/image3.jpg',
      title: 'Classic Hat',
      price: '\$20.00',
    ),
    ThriftItem(
      imageUrl: 'https://example.com/image4.jpg',
      title: 'Denim Jeans',
      price: '\$35.00',
    ),
    ThriftItem(
      imageUrl: 'https://example.com/image5.jpg',
      title: 'Leather Belt',
      price: '\$25.00',
    ),
    ThriftItem(
      imageUrl: 'https://example.com/image6.jpg',
      title: 'Floral Dress',
      price: '\$50.00',
    ),
    ThriftItem(
      imageUrl: 'https://example.com/image7.jpg',
      title: 'Wool Sweater',
      price: '\$40.00',
    ),
    ThriftItem(
      imageUrl: 'https://example.com/image8.jpg',
      title: 'Canvas Bag',
      price: '\$30.00',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SellioAppBar(
        title: 'Thrift',
        showNotificationIcon: false,
        showLeading: false,
      ),
      body:  CustomScrollView(
            slivers: [
              CategoryTabs(),
              GridProductsSection(),
          ]
      ),
    );
  }
}

class ThriftItem {
  final String imageUrl;
  final String title;
  final String price;

  ThriftItem({
    required this.imageUrl,
    required this.title,
    required this.price,
  });
}

class GridProductsSection extends StatefulWidget {
  const GridProductsSection({super.key});

  @override
  State<GridProductsSection> createState() => _GridProductsSectionState();
}

class _GridProductsSectionState extends State<GridProductsSection> {
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
      {
        'id': 2,
        'imageUrl': 'assets/images/product_3.png',
        'title': 'Product Name 3',
        'price': '\$30.99',
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
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 12,
              childAspectRatio: 180/272,
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
                onIncrement: () => incrementProduct(productId),
                onDecrement: () => decrementProduct(productId),
                onFavorite: () {},
              );
            },
          ),
        ],
      ),
    );
  }
}