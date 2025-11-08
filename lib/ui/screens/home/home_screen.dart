import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/app_management/route/routing.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';
import 'package:sellio_mobile/ui/screens/home/DataProvider.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/category_tabs.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/products_section.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/search_bar/search_widget.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/special_offer/special_offers_section.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/top_stores/top_stores_section.dart';
import 'package:sellio_mobile/ui/screens/search/search_screen.dart';
import 'home_app_bar.dart';

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
                  _buildSearchBarSection(context),

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

  SliverToBoxAdapter _buildSearchBarSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SearchScreen()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: AbsorbPointer(
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
            onLikePressed: (String productId) {
              // todo: Handle like action
            },
            onCardPressed: (String productId) {
              final store = DataProvider.topStores.isNotEmpty
                  ? DataProvider.topStores[0]
                  : null;

             context.navigator.pushStoreDetails(
                StoreDetailsArgs(
                  storeId: store?.name.hashCode.toString() ?? '123',
                  coverImage: store?.imageUrl ?? 'assets/images/product_3.webp',
                  profileImage: store?.imageUrl ?? 'assets/images/product_3.webp',
                  storeName: store?.name ?? "Sweet Lovers - Pasteleria",
                  rating: 3.8, // Default rating, as Store model doesn't have rating
                  discount: store?.discount ?? '40',
                ),
              );
            },
          ),
        )
    );
  }
}
