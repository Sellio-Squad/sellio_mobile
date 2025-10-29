import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';
import 'package:sellio_mobile/ui/screens/home/DataProvider.dart';
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
          backgroundColor: theme.colors.surfaceLow,
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: colors.surface,
        body: Stack(
          children: [
            Container(
              decoration:  BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(82, 8, 38, 1),
                    Color.fromRGBO(82, 8, 38, 0),
                  ],
                ),
              ),
            ),
            SafeArea(
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
          ],
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
          child: SpecialOffersSection(
            offers: DataProvider.specialOffers,
            onOfferTap: (offerId) {
              // todo: Handle offer tap
            },
          ),
        )
    );
  }

  SliverToBoxAdapter _buildTopStoresSection() {
    return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
          child: TopStoresSection(
            topStores: DataProvider.topStores,
            onLikePressed: () {
              // todo: Handle like action
            },
            onCardPressed: () {
              // todo: Handle store card tap
            },
          ),
        )
    );
  }
}
