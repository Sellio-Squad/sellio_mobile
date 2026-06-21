import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/presentation/screens/home/sections/top_stores/top_stores_list_shimmer.dart';
import 'package:sellio_mobile/presentation/screens/home/sections/trending_products/product_list_shimmer.dart';
import 'package:sellio_mobile/presentation/screens/search/widgets/filter_bottom_sheet.dart';
import 'package:sellio_mobile/presentation/screens/search/widgets/category_section.dart';
import 'package:sellio_mobile/presentation/screens/search/widgets/success_search.dart';
import '../../../di/injection_container.dart';
import '../../../domain/repositories/search_repository.dart';
import 'cubit/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(sl<SearchRepository>())..init(),
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colors.surfaceLow,
      appBar: SellioAppBar(
        title: context.local.search,
        showBackButton: true,
      ),
      body: CustomScrollView(
        slivers: [
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              final cubit = context.read<SearchCubit>();
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: SellioSearchBar(
                    hintText: context.local.search_your_favorite_items,
                    controller: _searchController,
                    isShowFilterIcon: state.hasResults,
                    onFilterIconClicked: _showFilterBottomSheet,
                    onTextSubmitted: cubit.search,
                  ),
                ),
              );
            },
          ),
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return SliverToBoxAdapter(
                child: switch (state) {
                  SearchInitial() => SellioInitialSearch(
                      title: context.local.start_exploring_your_favorite_items,
                    ),
                  SearchLoading() => state.selectedType == SearchType.products
                      ? ProductsListShimmerVertical()
                      : const TopStoresShimmer(itemCount: 10),
                  SearchRecent(:final recentSearches) => SellioRecentSearches(
                      recentSearches: recentSearches,
                      title: context.local.recent_searches,
                      clearAllText: context.local.clear_all,
                      onClearAllTap: context.read<SearchCubit>().clearRecent,
                      onChipTap: (text) {
                        _searchController.text = text;
                        context.read<SearchCubit>().selectRecent(text);
                      },
                    ),
                  SearchProductsSuccess() ||
                  SearchStoresSuccess() =>
                    SuccessSearch(state: state),
                  SearchEmpty() => SellioSearchEmptyState(
                      title: context.local.no_results_found,
                      subtitle: context.local
                          .please_check_your_spelling_or_try_a_different_search,
                      topWidget: const CategorySection(),
                    ),
                  _ => const SizedBox.shrink(),
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() async {
    final Map<String, dynamic>? filters = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const FilterBottomSheet(),
    );

    if (filters != null) {
      // If filters are returned (even an empty map for clearing), apply them.
      context.read<SearchCubit>().applyFilters(filters);
    }
  }
}

extension SearchStateX on SearchState {
  bool get hasResults =>
      this is SearchProductsSuccess || this is SearchStoresSuccess;
}