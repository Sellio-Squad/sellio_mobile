import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
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
      backgroundColor: context.theme.colors.surfaceLow,
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: thriftItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final item = thriftItems[index];
          return ProductVerticalCard(
            imageUrl: item.imageUrl,
            title: item.title,
            price: item.price,
            onIncrement: () {},
            onDecrement: () {},
          );
        },
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
