import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';
import 'package:sellio_mobile/core/design_system/widgets/cards/product_vertical_card.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/header_section.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/special_offer/special_offers_section.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/top_stores/top_stores_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = [
    'All',
    'Electronics',
    'Fashion',
    'Home',
    'Sports',
  ];

  // In your HomeScreen class, add mock data:
  final List<SpecialOfferModel> _specialOffers = [
    SpecialOfferModel(
      id: '1',
      imageUrl: 'assets/images/special_offer_1.png',
      title: 'Get 10% off on your first order',
      discount: '25% OFF',
    ),
    SpecialOfferModel(
      id: '2',
      imageUrl: 'assets/images/special_offer_1.png',
      title: 'Get 10% off on your first order',
      discount: '30% OFF',
    ),
    SpecialOfferModel(
      id: '3',
      imageUrl: 'assets/images/special_offer_1.png',
      title: 'Get 10% off on your first order',
      discount: '20% OFF',
    ),
  ];

  // Mock product counters
  final Map<int, int> _productCounts = {};

  final List<Store> _topStores = [
    Store(
      name: 'Gold Gallery Accessories',
      imageUrl: 'assets/images/store_accessories.png',
      discount: '25',
    ),
    Store(
      name: 'Sweet cake sweet',
      imageUrl: 'assets/images/store_sweet.png',
      discount: '30',
    ),
    Store(
      name: 'Techno store',
      imageUrl: 'assets/images/store_techno.png',
      discount: null,
    ),
  ];

  // Mock product data
  final List<Map<String, dynamic>> _products = List.generate(
    4,
        (index) => {
      'id': index,
      'imageUrl': 'https://picsum.photos/152/145?random=$index',
      'title': 'Product Name ${index + 1}',
      'price': '\$${(index + 1) * 10}.99',
    },
  );

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
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    final textTheme = theme.typography.textTheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header/AppBar
            HeaderSection(),

            // Search Bar
            _buildSearchBar(colors, textTheme),

            // Category Tabs
            _buildCategoryTabs(colors, textTheme),

            //  Special Offers Section
            _buildSpecialOffersSection(),

        /*    // Section Header for Products
            _buildSectionHeader(colors, textTheme),

            // Products Grid
            _buildProductsHorizontalList(),*/

            // Top Stores Section - Using TopStoresSection widget
            SliverToBoxAdapter(
              child: TopStoresSection(
                topStores: _topStores,
                onLikePressed: () {
                  // Handle like action
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Store added to favorites'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                onCardPressed: () {
                  // Handle store card tap
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Store pressed'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSpecialOffersSection() {
    return SliverToBoxAdapter(
      child: SpecialOffersSection(
        offers: _specialOffers,
        onOfferTap: (offerId) {
          // todo: Handle offer tap
        },
      ),
    );
  }

  // Search Bar
  SliverToBoxAdapter _buildSearchBar(colors, textTheme) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: colors.surfaceLow,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: colors.body, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    hintStyle: textTheme.bodyMedium.copyWith(
                      color: colors.body,
                    ),
                    border: InputBorder.none,
                  ),
                  style: textTheme.bodyMedium.copyWith(color: colors.title),
                ),
              ),
              Icon(Icons.filter_list, color: colors.body, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Category Tabs
  SliverToBoxAdapter _buildCategoryTabs(colors, textTheme) {
    return SliverToBoxAdapter(
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            final isSelected = _selectedCategoryIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? colors.primary : colors.surfaceLow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    _categories[index],
                    style: textTheme.labelMedium.copyWith(
                      color: isSelected ? Colors.white : colors.body,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Section Header for Products
  SliverToBoxAdapter _buildSectionHeader(colors, textTheme) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Featured Products',
              style: textTheme.titleLarge.copyWith(
                color: colors.title,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See All',
                style: textTheme.labelMedium.copyWith(color: colors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildProductsHorizontalList() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 260,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _products.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final product = _products[index];
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
    );
  }
}