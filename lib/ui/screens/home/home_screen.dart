import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/category_tabs.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/header_section.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/products_list.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/special_offer/special_offers_section.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/top_stores/top_stores_section.dart';


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
}