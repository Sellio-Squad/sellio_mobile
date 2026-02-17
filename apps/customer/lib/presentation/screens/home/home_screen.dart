import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/presentation/screens/home/sections/categories/categories_section.dart';
import 'package:sellio_mobile/presentation/screens/home/utils/add_dynamic_section.dart';
import 'package:sellio_mobile/presentation/screens/home/utils/home_navigation.dart';

import 'cubit/home_sections_cubit.dart';
import 'cubit/home_sections_state.dart';
import 'home_bloc_providers.dart';
import 'sections/electronics/electronics_section.dart';
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

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: HomeAppBar(
          onNotificationTap: () => navigateToNotifications(context),
          onSearchTap: () => navigateToSearch(context),
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: colors.surfaceLow,
        body: _HomeBody(colors: colors),
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
            child: BlocBuilder<HomeSectionsCubit, HomeSectionsState>(
              builder: (context, state) {
                return CustomScrollView(
                  slivers: _buildSections(state),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildSections(HomeSectionsState state) {
    final List<Widget> sections = [
      const SearchSection(),
      const SpecialOffersSection(),
    ];

    addDynamicSection(sections, state, 0);

    sections.add(const CategoriesSection());

    addDynamicSection(sections, state, 1);

    sections.add(const TrendingProductsSection());

    addDynamicSection(sections, state, 2);

    sections.addAll([
      const TopStoresSection(),
      const ElectronicsSection(),
    ]);

    if (state is HomeSectionsLoading) {
      sections.add(
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    } else if (state is HomeSectionsError) {
      sections.add(
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(child: Text(state.message)),
          ),
        ),
      );
    }

    sections.add(const SliverToBoxAdapter(child: SizedBox(height: 24)));
    return sections;
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
