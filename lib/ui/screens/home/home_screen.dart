import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/category_tabs.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/header_section.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/products_list.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/special_offer/special_offers_section.dart';

import '../../../core/design_system/constants/assets.dart';
import '../../../core/design_system/widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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

  // Mock data for top stores
  final List<Map<String, dynamic>> _topStores = [
    {
      'name': 'Nike',
      'logo': 'https://via.placeholder.com/60',
      'followers': '2.5M',
      'rating': 4.8,
    },
    {
      'name': 'Adidas',
      'logo': 'https://via.placeholder.com/60',
      'followers': '1.8M',
      'rating': 4.7,
    },
    {
      'name': 'Apple',
      'logo': 'https://via.placeholder.com/60',
      'followers': '5.2M',
      'rating': 4.9,
    },
    {
      'name': 'Samsung',
      'logo': 'https://via.placeholder.com/60',
      'followers': '3.1M',
      'rating': 4.6,
    },
    {
      'name': 'Zara',
      'logo': 'https://via.placeholder.com/60',
      'followers': '1.5M',
      'rating': 4.5,
    },
  ];

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
            CategoryTabs(),

            // Featured Banner/Carousel
            _buildSpecialOffersSection(),

            // Products Grid
            ProductsList(),

            // Top Stores Section
            _buildTopStoresSection(colors, textTheme),
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

  SliverToBoxAdapter _buildTopStoresSection(colors, textTheme) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SectionHeader(
              title: 'Top Stores',
              trailing: SvgPicture.asset(
                Assets.arrowRight,
                width: 20,
                height: 20,
              ),
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
}
