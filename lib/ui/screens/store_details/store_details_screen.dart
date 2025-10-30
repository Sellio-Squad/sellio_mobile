import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/constants/app_icons.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/ui/screens/about_store/about_store.dart';
import 'widgets/store_header.dart';
import 'widgets/store_info_card.dart';
import 'widgets/featured_items_section.dart'; // Add this import
import 'widgets/store_category_tabs.dart';
import 'widgets/store_products_list.dart';

class StoreDetailsScreen extends StatefulWidget {
  final String storeId;
  final String storeName;
  final String storeImageUrl;

  const StoreDetailsScreen({
    super.key,
    required this.storeId,
    required this.storeName,
    required this.storeImageUrl,
  });

  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  int _selectedCategoryIndex = 0;
  bool _isFavorite = false;

  final List<String> _categories = ['All', 'Cakes', 'Cupcakes', 'Donuts'];
  final String _openingHours = '11:00 AM - 12:00 PM';
  final bool _isOpen = true;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: _buildAppBar(context),
      body: CustomScrollView(
        slivers: [
          // Store Header (Banner)
          SliverToBoxAdapter(
            child: StoreHeader(
              imageUrl: widget.storeImageUrl,
              storeName: widget.storeName,
            ),
          ),

          // Store Info Card (Opening Hours)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: StoreInfoCard(
                openingHours: _openingHours,
                isOpen: _isOpen,
              ),
            ),
          ),

          // Featured Items Section - ADD THIS
          const FeaturedItemsSection(),

          // Spacing
          const SliverToBoxAdapter(
            child: SizedBox(height: 8),
          ),

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
          StoreProductsList(
            categoryIndex: _selectedCategoryIndex,
          ),
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
              MaterialPageRoute(
                builder: (context) => AboutStore(),
              ),
            );
          },
        ),
      ],
    );
  }
}