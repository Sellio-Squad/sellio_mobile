import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/category_tabs.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/products_list.dart';
import 'package:sellio_mobile/core/design_system/widgets/cards/product_vertical_card.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/search_bar/search_widget.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/special_offer/special_offers_section.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/top_stores/top_stores_section.dart';


import '../../../core/design_system/widgets/sellio_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    final textTheme = theme.typography.textTheme;

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: SellioAppBar(
            location: "Cairo,Egypt",
            userName: "Israa",
            showGreeting: true,
            backgroundColor: theme.colors.primaryVariant,
          ),
          backgroundColor: colors.surface,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                // Search Bar
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SearchBarWithFilter(
                      onFilterIconClicked: () {/** Todo */},
                      onTextSubmitted: (text) {/** Todo */},
                    ),
                  ),
                ),

            // Category Tabs
            CategoryTabs(),

            //  Special Offers Section
            _buildSpecialOffersSection(),

            // Products Grid
            ProductsList(),

            // Top Stores Section
            SliverToBoxAdapter(
              child: TopStoresSection(
                topStores: _topStores,
                onLikePressed: () {
                  // todo: Handle like action
                },
                onCardPressed: () {
                  // todo: Handle store card tap
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


  SliverToBoxAdapter _buildTopStoresSection(colors, textTheme) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Stores',
                  style: textTheme.titleLarge.copyWith(
                    color: colors.title,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: TextStyle(color: colors.primary),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _topStores.length,
              separatorBuilder: (_, __) => SizedBox(width: 12),
              itemBuilder: (context, index) {
                final store = _topStores[index];
                return _buildStoreCard(store, colors, textTheme);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreCard(store, colors, textTheme) {
    final hasDiscount = store['discount'] != null;

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 80,
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    store['logo'],
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                if (hasDiscount)
                  Positioned(
                    top: 4,
                    left: 4,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "${store['discount']}% OFF",
                        style: textTheme.labelSmall.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: InkWell(
                    onTap: () {},
                    child: Icon(Icons.favorite_border, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              store['name'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.labelMedium.copyWith(color: colors.title),
            ),
          ],
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
              width: 160, // عرض ثابت للكارت
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