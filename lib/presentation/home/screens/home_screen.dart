import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';
import '../../screens/store_details/store_details_screen.dart';
import '../DataProvider.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/category_tabs.dart';
import '../widgets/products_section.dart';
import '../widgets/search_bar/search_widget.dart';
import '../widgets/special_offer/special_offers_section.dart';
import '../widgets/top_stores_section.dart';

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
        appBar: HomeAppBar(
          userName: 'John Doe',
          location: 'New York, USA',
          onNotificationTap: () {
            // TODO: Handle notification
          },
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: colors.surfaceLow,
        body: Stack(
          children: [
            Container(
              height: 256,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    colors.primary.withOpacity(0.16),
                    colors.primary.withOpacity(0),
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
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
          padding: const EdgeInsets.fromLTRB(0, 24, 16, 0),
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
        )
    );
  }
}
