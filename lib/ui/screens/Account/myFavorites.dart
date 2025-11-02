import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import 'package:sellio_mobile/core/design_system/widgets/chip_category.dart';
import 'package:sellio_mobile/core/design_system/widgets/cards/product_vertical_card.dart';
import '../../../core/design_system/themes/sellio_colors.dart';
import '../../../core/design_system/themes/sellio_theme.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _selectedTabIndex = 0;

  final List<String> _tabs = ['Products', 'Stores'];

  final List<Map<String, dynamic>> _favoriteProducts = [
    {
      'id': 0,
      'imageUrl': 'assets/images/product_3.webp',
      'title': 'Birthday cake with bows',
      'price': '\$12.99',
    },
    {
      'id': 1,
      'imageUrl': 'assets/images/product_3.webp',
      'title': 'Berry Cake',
      'price': '\$12.99',
    },
    {
      'id': 2,
      'imageUrl': 'assets/images/product_3.webp',
      'title': 'Dark Chocolate Blackberry Cake',
      'price': '\$12.99',
    },
    {
      'id': 3,
      'imageUrl': 'assets/images/product_3.webp',
      'title': 'Tropical Coconut Cloud Cake',
      'price': '\$12.99',
    },
  ];

  final Map<int, int> _productCounts = {};

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colorScheme = theme.colors; // this is SellioColorScheme in your project

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colorScheme.surfaceLow,
        appBar: const SellioAppBar(
          title: 'Favorites',
          showBackButton: true,
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                  child: Row(
                    children: List.generate(_tabs.length, (index) {
                      final bool isSelected = _selectedTabIndex == index;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: ChipCategory(
                          label: _tabs[index],
                          assetIcon: index == 0 ? Assets.food : Assets.clothes,
                          selected: isSelected,
                          onTap: () {
                            setState(() {
                              _selectedTabIndex = index;
                            });
                          },
                        ),
                      );
                    }),
                  ),
              ),
              if (_selectedTabIndex == 0)
                _buildFavoriteProductsGrid(context)
              else
                _buildEmptyStoresState(colorScheme),
            ],
          ),
        ),
      ),
    );
  }

  /// PRODUCTS GRID
  Widget _buildFavoriteProductsGrid(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colorScheme = theme.colors;

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final product = _favoriteProducts[index];
            final productId = product['id'] as int;
            final count = _productCounts[productId] ?? 0;

            return ProductVerticalCard(
              imageUrl: product['imageUrl'],
              title: product['title'],
              price: product['price'],
              count: count,
              onIncrement: () {
                setState(() {
                  _productCounts[productId] = count + 1;
                });
              },
              onDecrement: () {
                setState(() {
                  if (count > 0) _productCounts[productId] = count - 1;
                });
              },
              onFavorite: () {
                setState(() {
                  _favoriteProducts.removeAt(index);
                });
              },
            );
          },
          childCount: _favoriteProducts.length,
        ),
      ),
    );
  }

  Widget _buildEmptyStoresState(SellioColorScheme colorScheme) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 64),
        child: Center(
          child: Column(
            children: [
              SvgPicture.asset(
                Assets.add,
                height: 120,
                width: 120,
                colorFilter: ColorFilter.mode(
                  colorScheme.primary.withOpacity(0.4),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'No favorite stores yet',
                style: TextStyle(
                  color: colorScheme.green,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
