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
  final List<String> recentSearches = [
    'Cake',
    'T-Shirt',
    'Gift',
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
            if(recentSearches.isEmpty)
            _buildCategorySection(context)

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
  
  String _selectedCategory = 'Products';

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
}
