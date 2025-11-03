import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import 'package:sellio_mobile/core/design_system/widgets/chip_category.dart';
import 'package:sellio_mobile/core/design_system/widgets/cards/product_vertical_card.dart';
import 'package:sellio_mobile/ui/screens/home/DataProvider.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/top_stores/top_stores_section.dart';
import 'package:sellio_mobile/ui/screens/store_details/store_details_screen.dart';
import '../../../../core/design_system/themes/sellio_colors.dart';
import '../../../../core/design_system/themes/sellio_theme.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _selectedTabIndex = 0;

  final List<String> _tabs = ['Products', 'Stores'];
  final Map<int, int> _productCounts = {};

  final List<Map<String, dynamic>> _favoriteProducts = [
    {
      'id': 0,
      'imageUrl': 'assets/images/product_3.webp',
      'title': 'Birthday cake with bows',
      'price': '\$12.99',
      'isFavorite': true,
    },
    {
      'id': 1,
      'imageUrl': 'assets/images/product_3.webp',
      'title': 'Berry Cake',
      'price': '\$12.99',
      'isFavorite': true,
    },
    {
      'id': 2,
      'imageUrl': 'assets/images/product_3.webp',
      'title': 'Dark Chocolate Blackberry Cake',
      'price': '\$12.99',
      'isFavorite': false,
    },
    {
      'id': 3,
      'imageUrl': 'assets/images/product_3.webp',
      'title': 'Tropical Coconut Cloud Cake',
      'price': '\$12.99',
      'isFavorite': false,
    },
    {
      'id': 4,
      'imageUrl': 'assets/images/product_3.webp',
      'title': 'Vanilla Dream Cake',
      'price': '\$12.99',
      'isFavorite': false,
    },
    {
      'id': 5,
      'imageUrl': 'assets/images/product_3.webp',
      'title': 'Strawberry Delight',
      'price': '\$12.99',
      'isFavorite': false,
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
      final index = _favoriteProducts.indexWhere((p) => p['id'] == productId);
      if (index != -1) {
        _favoriteProducts[index]['isFavorite'] =
        !_favoriteProducts[index]['isFavorite'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colorScheme = theme.colors;

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
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    children: List.generate(_tabs.length, (index) {
                      final bool isSelected = _selectedTabIndex == index;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: ChipCategory(
                          label: _tabs[index],
                          assetIcon:
                          index == 0 ? Assets.food : Assets.clothes,
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
              ),
              if (_selectedTabIndex == 0)
                _buildProductsGrid()
              else
                _buildTopStoresSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductsGrid() {
    final favoriteItems =
    _favoriteProducts.where((item) => item['isFavorite'] == true).toList();

    if (favoriteItems.isEmpty) {
      return _buildEmptyStoresState();
    }

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.68,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final product = favoriteItems[index];
            final productId = product['id'] as int;
            final count = _productCounts[productId] ?? 0;

            return ProductVerticalCard(
              imageUrl: product['imageUrl'],
              title: product['title'],
              price: product['price'],
              count: count,
              onIncrement: () => _incrementProduct(productId),
              onDecrement: () => _decrementProduct(productId),
              onFavorite: () => _toggleFavorite(productId),
            );
          },
          childCount: favoriteItems.length,
        ),
      ),
    );
  }

  Widget _buildTopStoresSection() {
    if (DataProvider.topStores.isEmpty) {
      return _buildEmptyStoresState();
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
        child: TopStoresSection(
          topStores: DataProvider.topStores,
          onLikePressed: () {
            // Handle like action
          },
          onCardPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoreDetailsScreen(
                  storeId: '123',
                  coverImage: 'assets/images/product_3.webp',
                  profileImage: 'assets/images/product_3.webp',
                  storeName: "Sweet Lovers - Pasteleria",
                  rating: 3.8,
                  discount: '40',
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyStoresState() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 200),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  width: 112,
                  height: 112,
                  decoration: BoxDecoration(
                    color: SellioColors.light.primaryVariant,
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      Assets.heartRemove,
                      width: 64,
                      height: 64,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'No favourite items!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xE01F1F1F),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Start exploring and saving your favorite items here.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.57,
                  color: Color.fromARGB(255, 102, 102, 102),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: SellioColors.light.primary,
                  fixedSize: const Size(160, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  shadowColor: Colors.black.withOpacity(0.1),
                  elevation: 4,
                ),
                onPressed: () {
                  // TODO: Navigate to Explore/Home section
                },
                child: const Text(
                  'Start Exploring',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 1.57,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
