import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sellio_mobile/core/design_system/constants/app_strings.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/chip_category.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import 'package:sellio_mobile/ui/screens/home/widgets/search_bar/search_widget.dart';

import '../../../core/design_system/constants/assets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _selectedCategory = 'Products';

  final List<String> recentSearches = [
    'Cake',
    'Donut',
    'Cola Diet',
    'Lemonade',
    'مرطب سميل',
    'Cat accessories',
    'عباية خليجي',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.colors.surfaceLow,
        appBar: SellioAppBar(
        title: AppStrings.search,
        showBackButton: true,
      ),
      body: CustomScrollView(
          slivers:[
            _buildSearchBarSection(context),
            _buildSearchBodySection(context),
          ]
      )

    );
  }

  SliverToBoxAdapter _buildSearchBarSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,),
        child: SearchBarWithFilter(
            onFilterIconClicked: (){},
            onTextSubmitted: (String text){}
        ),
      ),

    );
  }

  SliverToBoxAdapter _buildSearchBodySection(BuildContext context){
    SearchState _state = SearchState.initial;
    return SliverToBoxAdapter(
      child: switch(_state){
        SearchState.initial => _buildInitialSearch(context),

        SearchState.recent => _buildRecentSearch(context),

        SearchState.success => _buildSuccessSearch(context),

        SearchState.noResult => _buildNoResultSearch(context),
      }
    );
  }


  SliverToBoxAdapter _buildCategorySection(BuildContext context){
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Row(
          children: [
            ChipCategory(label: 'Products',
              selected: _selectedCategory == 'Products',
              onTap: (){
              setState(() {
                _selectedCategory = 'Products';
              });
            } , assetIcon: Assets.orderIcon,),
            const Gap(8),
            ChipCategory(label: 'Stores',
              selected: _selectedCategory == 'Stores',
              onTap: (){
              setState(() {
                _selectedCategory = 'Stores';
              });
            }, assetIcon: Assets.storeIcon,),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Searches',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: context.theme.colors.title,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    recentSearches.clear();
                  });
                },
                child: Text(
                  'Clear All',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: context.theme.colors.primary,
                  ),
                ),
              ),
            ],
          ),
          const Gap(12),

          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: recentSearches.map((text) {
              return ChipCategory(
                  label: text,
                  selected: false,
                  onTap: (){
                  });
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialSearch(BuildContext context){
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Assets.searchIcon),
          Text('Start exploring your favorite items!',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: context.theme.colors.title,
              )
          ),
        ]
      ),
    );
  }

  Widget _buildSuccessSearch(BuildContext context){
    return Center();
  }
  Widget _buildNoResultSearch(BuildContext context){
    return Center();
  }
}

enum SearchState{
  initial,
  recent,
  success,
  noResult
}

