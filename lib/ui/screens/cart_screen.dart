import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import '../../core/design_system/widgets/buttons/button.dart';
import '../../core/design_system/widgets/cards/productHorizontalCard.dart';
import '../../core/design_system/widgets/textField.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> _items = [
    {
      'title': 'Lemon Chantilly Cake',
      'description':
      'A soft, fluffy cake with a refreshing lemon flavor, baked daily using 100% natural ingredients ...',
      'price': '\$12.99',
      'originalPrice': '\$16.99',
      'image': Assets.cakeHouseLogo,
      'count': 1,
    },
    {
      'title': 'Moist Chocolate Cake',
      'description':
      'Rich, moist chocolate cake baked fresh daily with top-quality ingredients ...',
      'price': '\$15.99',
      'originalPrice': null,
      'image': Assets.cakeHouseLogo,
      'count': 2,
    },
    {
      'title': 'Red Velvet Strawberry Cheesecake',
      'description':
      'A rich red velvet base topped with creamy cheesecake and fresh strawberries ...',
      'price': '\$15.99',
      'originalPrice': null,
      'image': Assets.cakeHouseLogo,
      'count': 1,
    },
  ];

  final TextEditingController _noteController = TextEditingController();

  double get totalPrice {
    double total = 0;
    for (var item in _items) {
      total += double.parse(item['price'].replaceAll('\$', '')) * item['count'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    final textTheme = theme.typography.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                'Add more items',
                style: textTheme.labelMedium.copyWith(color: colors.primary),
              ),
            ),
          ),
        ],
      ),

      // Scrollable body content
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_items.length} items',
                  style: textTheme.labelMedium.copyWith(color: colors.body),
                ),
                Text(
                  'Select',
                  style:
                  textTheme.labelMedium.copyWith(color: colors.primary),
                ),
              ],
            ),
            const Gap(8),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _items.length,
              separatorBuilder: (_, __) => const Gap(8),
              itemBuilder: (context, index) {
                final item = _items[index];
                return ProductHorizontalCard(
                  imageUrl: item['image'],
                  title: item['title'],
                  description: item['description'],
                  price: item['price'],
                  originalPrice: item['originalPrice'],
                  count: item['count'],
                  onIncrement: () {
                    setState(() => item['count']++);
                  },
                  onDecrement: () {
                    if (item['count'] > 0) {
                      setState(() => item['count']--);
                    }
                  },
                );
              },
            ),
            const Gap(8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colors.stroke),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Note about order',
                    style:
                    textTheme.labelMedium.copyWith(color: colors.title),
                  ),
                  SellioTextField(
                    controller: _noteController,
                    isParagraph: true,
                    hintText: 'Write here',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: context.theme.colors.surfaceLow,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, -4),
              blurRadius: 8,
            ),
          ],
        ),
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total price',
                  style:
                  textTheme.titleSmall.copyWith(color: colors.title),
                ),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style:
                  textTheme.titleSmall.copyWith(color: colors.primary),
                ),
              ],
            ),
            const Gap(12),
            SellioButton(
              text: 'Confirm Order (${_items.length})',
              onTap: () {},
              backgroundColor: colors.primary,
              isEnabled: true,
              fullWidth: true,
            ),
          ],
        ),
      ),
    );
  }
}