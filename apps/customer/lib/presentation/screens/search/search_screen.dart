import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import '../../../presentation/screens/home/sections/search/widgets/search_bar_widget.dart';
import '../../cubits/search/cubit/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit()..init(),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView();

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Products';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();

    return Scaffold(
      backgroundColor: context.theme.colors.surfaceLow,
      appBar: SellioAppBar(
        title: context.local.search,
        showBackButton: true,
      ),
      body: CustomScrollView(
        slivers: [
          _buildSearchBarSection(context, cubit),
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return SliverToBoxAdapter(
                child: switch (state) {
                  SearchInitial() => _buildInitialSearch(context),
                  SearchRecent(:final recentSearches) =>
                    _buildRecentSearch(context, recentSearches, cubit),
                  SearchSuccess() => _buildSuccessSearch(context),
                  SearchEmpty() => _buildNoResultSearch(context),
                  // TODO: Handle this case.
                  SearchState() => throw UnimplementedError(),
                },
              );
            },
          ),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildSearchBarSection(
      BuildContext context, SearchCubit cubit) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SearchBarWithFilter(
          controller: _searchController,
          onFilterIconClicked: () {},
          onTextSubmitted: cubit.search,
        ),
      ),
    );
  }

  Widget _buildRecentSearch(
    BuildContext context,
    List<String> recentSearches,
    SearchCubit cubit,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(context.local.recent_searches),
              GestureDetector(
                onTap: cubit.clearRecent,
                child: Text(
                  context.local.clear_all,
                  style: TextStyle(color: context.theme.colors.primary),
                ),
              ),
            ],
          ),
          const Gap(12),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: recentSearches.map((text) {
              return SellioChip(
                label: text,
                selected: false,
                onTap: () {
                  _searchController.text = text;
                  cubit.selectRecent(text);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialSearch(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.searchIcon),
          Text(context.local.start_exploring_your_favorite_items),
        ],
      ),
    );
  }

  Widget _buildSuccessSearch(BuildContext context) {
    return Column(
      children: [
        _buildCategorySection(context),
        // TODO implement search result here
      ],
    );
  }

  Widget _buildNoResultSearch(BuildContext context) {
    return Column(
      children: [
        _buildCategorySection(context),
        const Gap(24),
        Image.asset(AppImages.noResultSearchIcon),
        Text(context.local.no_results_found),
        Text(
          context.local.please_check_your_spelling_or_try_a_different_search,
        ),
      ],
    );
  }

  Widget _buildCategorySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          SellioChip(
            label: context.local.products,
            selected: _selectedCategory == 'Products',
            onTap: () => setState(() => _selectedCategory = 'Products'),
          ),
          const Gap(8),
          SellioChip(
            label: context.local.stores,
            selected: _selectedCategory == 'Stores',
            onTap: () => setState(() => _selectedCategory = 'Stores'),
          ),
        ],
      ),
    );
  }
}
