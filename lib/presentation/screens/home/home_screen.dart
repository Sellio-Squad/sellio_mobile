import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';
import 'package:sellio_mobile/presentation/screens/home/utils/home_navigation.dart';
import 'home_bloc_providers.dart';
import 'home_listeners.dart';
import 'sections/categories/categories_section.dart';
import 'sections/search/search_section.dart';
import 'sections/special_offers/special_offers_section.dart';
import 'sections/top_stores/top_stores_section.dart';
import 'sections/trending_products/trending_products_section.dart';
import 'utils/home_refresh_handler.dart';
import 'widgets/home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeBlocProviders(
      child: _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatelessWidget {
  const _HomeScreenContent();

  @override
  Widget build(BuildContext context) {
    final colors = SellioTheme.of(context).colors;

    return HomeListeners(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: HomeAppBar(
            onNotificationTap: () => navigateToNotifications(context),
          ),
          extendBodyBehindAppBar: true,
          backgroundColor: colors.surfaceLow,
          body: _HomeBody(colors: colors),
        ),
      ),
    );
  }
}
class _HomeBody extends StatelessWidget {
  final dynamic colors;

  const _HomeBody({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _GradientBackground(colors: colors),
        SafeArea(
          child: RefreshIndicator(
            onRefresh: () => handleHomeRefresh(context),
            child: CustomScrollView(
              slivers: _buildSections(),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildSections() {
    return const [
      SearchSection(),
      CategoriesSection(),
      SpecialOffersSection(),
      TrendingProductsSection(),
      TopStoresSection(),
      SliverToBoxAdapter(child: SizedBox(height: 24)),
    ];
  }
}

class _GradientBackground extends StatelessWidget {
  final dynamic colors;

  const _GradientBackground({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 256,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colors.primary.withOpacity(0.16),
            colors.primary.withOpacity(0.0),
          ],
        ),
      ),
    );
  }
}