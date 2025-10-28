import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';
import '../../../core/design_system/widgets/sellio_app_bar.dart';
import 'DataProvider.dart';
import 'widgets/category_tabs.dart';
import 'widgets/products_section.dart';
import 'widgets/search_bar/search_widget.dart';
import 'widgets/special_offer/special_offers_section.dart';
import 'widgets/top_stores/top_stores_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              _buildSearchBarSection(),

              // Category Tabs
              CategoryTabs(),

              //  Special Offers Section
              _buildSpecialOffersSection(),

              // Products Grid
              ProductsSection(),

              // Top Stores Section
              _buildTopStoresSection(),
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSearchBarSection() {
    return SliverToBoxAdapter(
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
    );
  }

  SliverToBoxAdapter _buildSpecialOffersSection() {
    return SliverToBoxAdapter(
      child: SpecialOffersSection(
        offers: DataProvider.specialOffers,
        onOfferTap: (offerId) {
          // todo: Handle offer tap
        },
      ),
    );
  }

  SliverToBoxAdapter _buildTopStoresSection() {
    return SliverToBoxAdapter(
      child: TopStoresSection(
        topStores: DataProvider.topStores,
        onLikePressed: () {
          // todo: Handle like action
        },
        onCardPressed: () {
          // todo: Handle store card tap
        },
      ),
    );
  }
}
