import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/presentation/screens/home/sections/top_stores/top_stores_list_shimmer.dart';
import 'package:sellio_mobile/presentation/screens/home/sections/trending_products/product_list_shimmer.dart';
import 'package:sellio_mobile/presentation/screens/search/widgets/filter_bottom_sheet.dart';
import 'package:sellio_mobile/presentation/screens/search/widgets/initial_search.dart';
import 'package:sellio_mobile/presentation/screens/search/widgets/no_result.dart';
import 'package:sellio_mobile/presentation/screens/search/widgets/recent_search.dart';
import 'package:sellio_mobile/presentation/screens/search/widgets/search_bar.dart';
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
              return SearchBarSection(
                searchController: _searchController,
                isShowFilterIcon: state.hasResults,
                onFilterIconClicked: _showFilterBottomSheet,
              );
            },
          ),

          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return SliverToBoxAdapter(
                child: switch (state) {
                  SearchInitial() =>
                      InitialSearch(context),

                  SearchLoading() => state.selectedType == SearchType.products
                      ? ProductsListShimmer()
                      : const TopStoresShimmer(),

                  SearchRecent(:final recentSearches) =>
                      RecentSearchSection(
                        recentSearches: recentSearches,
                        searchController: _searchController,
                      ),

                  SearchProductsSuccess() || SearchStoresSuccess() =>
                      SuccessSearch(state: state),


                  SearchEmpty() =>
                  const NoResult(),
                  _ =>
                  const SizedBox.shrink(),
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) => const FilterBottomSheet(),
    );
  }
}

extension SearchStateX on SearchState {
  bool get hasResults =>
      this is SearchProductsSuccess || this is SearchStoresSuccess;
}
