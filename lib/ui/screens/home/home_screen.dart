import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/category_tabs.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/products_section.dart';
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
                    onFilterIconClicked: () {
                      // todo: Handle filter icon click
                    },
                    onTextSubmitted: (text) {
                      // todo: Handle search text submission
                    },
                  ),
                ),
              ),

              // Category Tabs
              CategoryTabs(),

              //  Special Offers Section
              _buildSpecialOffersSection(),

              // Products Grid
              ProductsSection(),

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
}
