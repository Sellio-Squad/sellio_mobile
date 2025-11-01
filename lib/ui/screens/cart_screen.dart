import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/ui/screens/home/home_screen.dart';
import '../../core/design_system/constants/app_strings.dart';
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
      backgroundColor: colors.surfaceLow,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(68),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: AppBar(
            backgroundColor: colors.surfaceLow,
            title: Text(
              AppStrings.cart,
              style: context.theme.typography.textTheme.titleMedium
                  .copyWith(color: context.theme.colors.title),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Center(
                  child: Text(
                    AppStrings.addMoreItems,
                    style: textTheme.labelMedium.copyWith(color: colors.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 46),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_items.length} ${AppStrings.items}',
                  style: textTheme.labelMedium.copyWith(color: colors.body),
                ),
                Text(
                  AppStrings.select,
                  style: textTheme.labelMedium.copyWith(color: colors.primary),
                ),
              ],
            ),
            const Gap(12),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _items.length,
              separatorBuilder: (_, __) => const Gap(12),
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
            const Gap(12),
            Divider(
              color: colors.stroke,
              thickness: 1,
            ),
            const Gap(12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.noteAboutOrder,
                  style: textTheme.titleMedium.copyWith(color: colors.title),
                ),
                const Gap(8),
                SellioTextField(
                  controller: _noteController,
                  isParagraph: true,
                  hintText: AppStrings.writeHere,
                  maxLine: 1,
                ),
              ],
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  Assets.discountTag,
                  ),
                const Gap(1),
                Text(
                  AppStrings.totalPrice,
                  style: textTheme.titleSmall.copyWith(color: colors.title),
                ),
                const Spacer(),
                Text(
                  '\$${totalPrice.toStringAsFixed(2)}',
                  style: textTheme.titleSmall.copyWith(color: colors.primary),
                ),
              ],
            ),
            const Gap(12),
            SellioButton(
              text: '${AppStrings.confirmOrder} (${_items.length})',
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24),
                            width: 112,
                            height: 112,
                            decoration: BoxDecoration(
                              color: context.theme.colors.primaryVariant,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              Assets.packageDelivered,
                              colorFilter: ColorFilter.mode(
                                context.theme.colors.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '${AppStrings.order} #2002124',
                            style: context.theme.typography.textTheme.labelMedium
                                .copyWith(color: context.theme.colors.title),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            AppStrings.orderReceived,
                            style: context.theme.typography.textTheme.titleSmall
                                .copyWith(color: context.theme.colors.body),
                          ),
                          const SizedBox(height: 24),
                          SellioButton(
                            text: AppStrings.backToShopping,
                            backgroundColor: context.theme.colors.primaryVariant,
                            textStyle: context.theme.typography.textTheme.labelMedium
                                .copyWith(color: context.theme.colors.primary),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            },
                            fullWidth: true,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              backgroundColor: colors.primary,
              isEnabled: true,
              fullWidth: true,
              suffixSvgPath: Assets.packageAdd,
            ),
          ],
        ),
      ),
    );
  }
}