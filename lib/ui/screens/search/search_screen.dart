import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sellio_mobile/core/design_system/constants/app_strings.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/chip_category.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

import '../../../core/design_system/constants/assets.dart';
import '../../../core/design_system/widgets/cards/product_vertical_card.dart';
import '../../../presentation/screens/home/widgets/search_bar/search_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchText = '';
  String _selectedCategory = 'Products';
  final TextEditingController _searchController = TextEditingController();

  final List<String> recentSearches =
  [
    'Cake',
    'Donut',
    'Cola Diet',
    'Lemonade',
    'مرطب سميل',
    'Cat accessories',
    'عباية خليجي',
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

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
          title: AppStrings.search,
          showBackButton: true,
        ),
        body: CustomScrollView(slivers: [
          _buildSearchBarSection(context),
          _buildSearchBodySection(context),
        ]));
  }

  SliverToBoxAdapter _buildSearchBarSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: SearchBarWithFilter(
            onFilterIconClicked: () {},
            onTextSubmitted: (String text) {
            },
            controller: _searchController),
      ),
    );
  }

  SliverToBoxAdapter _buildSearchBodySection(BuildContext context) {
    late final SearchState state;

    if (_searchText.isEmpty) {
      if (recentSearches.isEmpty) {
        state = SearchState.initial;
      } else {
        state = SearchState.recent;
      }
    } else {
      if (recentSearches.isEmpty) {
        state = SearchState.noResult;
      } else {
        state = SearchState.success;
      }
    }

    return SliverToBoxAdapter(
      child: switch (state) {
        SearchState.initial => _buildInitialSearch(context),
        SearchState.recent => _buildRecentSearch(context),
        SearchState.success => _buildSuccessSearch(context),
        SearchState.noResult => _buildNoResultSearch(context),
      },
    );
  }

  Widget _buildCategorySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Row(
        children: [
          ChipCategory(
            label: context.local.products,
            selected: _selectedCategory == 'Products',
            onTap: () {
              setState(() {
                _selectedCategory = 'Products';
              });
            },
            assetIcon: Assets.orderIcon,
          ),
          const Gap(8),
          ChipCategory(
            label: context.local.stores,
            selected: _selectedCategory == 'Stores',
            onTap: () {
              setState(() {
                _selectedCategory = 'Stores';
              });
            },
            assetIcon: Assets.storeIcon,
          ),
        ],
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
                context.local.recent_searches,
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
                  context.local.clear_all,
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
                  onTap: () {
                    setState(() {
                      _searchText = text;
                      _searchController.text = text;
                    });
                  });
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(Assets.searchIcon),
            Text(
            context.local.start_exploring_your_favorite_items,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: context.theme.colors.title,
                    )),
          ]),
    );
  }

  Widget _buildSuccessSearch(BuildContext context) {
    return Column(
      children: [
        _buildCategorySection(context),
         GridProductsSection(),

      ],
    );
  }

  Widget _buildNoResultSearch(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildCategorySection(context),
          const Spacer(),
          Image.asset(
            Assets.noResultSearchIcon,
          ),
          Text(
              context.local.no_results_found,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: context.theme.colors.title,
                  )),

          Text(
              context.local.please_check_your_spelling_or_try_a_different_search,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.theme.colors.body,
                  )),
          Spacer()
        ],
      ),
    );
  }
}

enum SearchState { initial, recent, success, noResult }


class GridProductsSection extends StatefulWidget {
  const GridProductsSection({super.key});

  @override
  State<GridProductsSection> createState() => _GridProductsSectionState();
}

class _GridProductsSectionState extends State<GridProductsSection> {
  final Map<int, int> _productCounts = {};
  bool _isFavourite = false;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {
        'id': 0,
        'imageUrl': 'assets/images/product_3.webp',
        'title': 'Gold Stainless Steel Sun Charm Necklace',
        'price': '\$5.00',
        'isFavourite': _isFavourite,
      },
      {
        'id': 1,
        'imageUrl': 'assets/images/product_3.webp',
        'title': 'Birthday cake with bows',
        'price': '\$12.99',
        'isFavourite': _isFavourite,
      },
      {
        'id': 3,
        'imageUrl': 'assets/images/product_3.webp',
        'title': 'Product Name 3',
        'price': '\$30.99',
        'isFavourite': _isFavourite,
      },
      {
        'id': 4,
        'imageUrl': 'assets/images/product_3.webp',
        'title': 'Birthday cake with bows',
        'price': '\$12.99',
        'isFavourite': _isFavourite,
      },
      {
        'id': 5,
        'imageUrl': 'assets/images/product_3.webp',
        'title': 'Product Name 3',
        'price': '\$30.99',
        'isFavourite': _isFavourite,
      },
      {
        'id': 6,
        'imageUrl': 'assets/images/product_3.webp',
        'title': 'Product Name 3',
        'price': '\$30.99',
        'isFavourite': _isFavourite,
      },
      {
        'id': 7,
        'imageUrl': 'assets/images/product_3.webp',
        'title': 'Birthday cake with bows',
        'price': '\$12.99',
        'isFavourite': _isFavourite,
      },
      {
        'id': 8,
        'imageUrl': 'assets/images/product_3.webp',
        'title': 'Product Name 3',
        'price': '\$30.99',
        'isFavourite': _isFavourite,
      },
    ];

    void incrementProduct(int productId) {
      setState(() {
        _productCounts[productId] = (_productCounts[productId] ?? 0) + 1;
      });
    }

    void decrementProduct(int productId) {
      setState(() {
        final count = _productCounts[productId] ?? 0;
        if (count > 0) {
          _productCounts[productId] = count - 1;
        }
      });
    }

    void toggleFavourite(int productId) {
      setState(() {
        _isFavourite = !_isFavourite;
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 12,
            childAspectRatio: 170 / 272,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            final productId = product['id'] as int;
            final count = _productCounts[productId] ?? 0;

            return ProductVerticalCard(
              imageUrl: product['imageUrl'],
              title: product['title'],
              price: product['price'],
              count: count,
              isFavorite: product['isFavourite'],
              onIncrement: () => incrementProduct(productId),
              onDecrement: () => decrementProduct(productId),
              onFavorite: () => toggleFavourite(productId),
            );
          },
        ),
      ],
    );
  }
}

