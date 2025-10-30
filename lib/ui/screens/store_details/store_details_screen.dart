import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/constants/app_icons.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/ui/screens/store_details/widgets/store_header.dart';
import 'package:sellio_mobile/ui/screens/store_details/widgets/store_info_card.dart';

import 'about_store/about_store.dart';
import 'widgets/featured_items_section.dart';
import 'widgets/store_category_tabs.dart';
import 'widgets/store_products_list.dart';

class StoreDetailsScreen extends StatefulWidget {
  final String storeId;
  final String coverImage;
  final String profileImage;
  final String storeName;
  final String discount;
  final double rating;

  const StoreDetailsScreen({
    super.key,
    required this.storeId,
    required this.coverImage,
    required this.profileImage,
    required this.storeName,
    required this.discount,
    required this.rating,
  });

  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  int _selectedCategoryIndex = 0;
  bool _isFavorite = false;

  final List<String> _categories = ['All', 'Cakes', 'Cupcakes', 'Donuts'];

  // Example details to feed StoreInfoOverview
  final String _location = 'Baghdad, Iraq';
  final List<String> _tags = ['Cake', 'Donut', 'Dessert'];
  final String _description =
      'Luxurious flavors, enchanting designs, and cakes made with love 💕\nOrder your favorite cake from Cake by Heart now and enjoy your sweet moments 🍰';

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: _buildAppBar(context),
      body: CustomScrollView(
        slivers: [
          // Store Header (Banner) with required parameters
          SliverToBoxAdapter(
            child: StoreHeader(
              coverImage: widget.coverImage,
              profileImage: widget.profileImage,
              storeName: widget.storeName,
              discount: widget.discount,
            ),
          ),

          // Store Info Card with required parameters
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: StoreInfoOverview(
                location: _location,
                rating: widget.rating,
                tags: _tags,
                description: _description,
              ),
            ),
          ),

          // Featured Items Section
          const FeaturedItemsSection(),

          // Spacing
          const SliverToBoxAdapter(child: SizedBox(height: 8)),

          // Category Tabs
          StoreCategoryTabs(
            categories: _categories,
            selectedIndex: _selectedCategoryIndex,
            onCategorySelected: (index) {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
          ),

          // Products List
          StoreProductsList(categoryIndex: _selectedCategoryIndex),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;

    return AppBar(
      backgroundColor: colors.surfaceLow,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: colors.title),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        widget.storeName,
        style: theme.typography.textTheme.titleMedium.copyWith(
          color: colors.title,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: _isFavorite ? colors.red : colors.title,
          ),
          onPressed: () {
            setState(() {
              _isFavorite = !_isFavorite;
            });
          },
        ),
        IconButton(
          icon: SvgPicture.asset(AppIcons.alertCircle, width: 24, height: 24),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutStore()),
            );
          },
        ),
      ],
    );
  }
}
