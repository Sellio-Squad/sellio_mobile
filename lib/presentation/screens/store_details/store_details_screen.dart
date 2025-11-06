import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/constants/app_icons.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import '../../../core/design_system/constants/assets.dart';
import 'about_store/about_store.dart';
import 'store_data_provider.dart';
import 'widgets/featured_items_section.dart';
import 'widgets/store_category_tabs.dart';
import 'widgets/store_header.dart';
import 'widgets/store_info_card.dart';
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
  static const double _horizontalPadding = 16.0;
  static const double _verticalPadding = 8.0;
  static const double _sectionSpacing = 8.0;
  static const double _iconSize = 24.0;

  int _selectedCategoryIndex = 0;
  bool _isFavorite = false;

  late final StoreDataProvider _dataProvider;
  late final StoreDetailsData _storeData;

  @override
  void initState() {
    super.initState();
    _dataProvider = StoreDataProvider();
    _storeData = _dataProvider.getStoreDetails(widget.storeId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return CustomScrollView(
      slivers: [
        _buildStoreHeader(),
        _buildStoreInfoCard(),
        _buildFeaturedItemsSection(),
        _buildSectionSpacing(),
        _buildCategoryTabs(),
        _buildProductsList(),
      ],
    );
  }

  Widget _buildStoreHeader() {
    return SliverToBoxAdapter(
      child: StoreHeader(
        coverImage: widget.coverImage,
        profileImage: widget.profileImage,
        storeName: widget.storeName,
        discount: widget.discount,
      ),
    );
  }

  Widget _buildStoreInfoCard() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          _horizontalPadding,
          _verticalPadding,
          _horizontalPadding,
          _verticalPadding,
        ),
        child: StoreInfoOverview(
          location: _storeData.location,
          rating: widget.rating,
          tags: _storeData.tags,
          description: _storeData.description,
        ),
      ),
    );
  }

  Widget _buildFeaturedItemsSection() {
    return const SliverToBoxAdapter(
      child: FeaturedItemsSection(),
    );
  }

  Widget _buildSectionSpacing() {
    return const SliverToBoxAdapter(
      child: SizedBox(height: _sectionSpacing),
    );
  }

  Widget _buildCategoryTabs() {
    return SliverToBoxAdapter(
      child: StoreCategoryTabs(
        categories: _storeData.categories,
        selectedIndex: _selectedCategoryIndex,
        onCategorySelected: _onCategorySelected,
      ),
    );
  }

  Widget _buildProductsList() {
    return SliverPadding(
      padding: const EdgeInsets.all(_horizontalPadding),
      sliver: StoreProductsList(
        categoryIndex: _selectedCategoryIndex,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colors;

    return SellioAppBar(
      showBackButton: true,
      title: widget.storeName,
      actions: [
        _buildFavoriteButton(colors),
        _buildInfoButton(),
      ],
    );

  }

  Widget _buildFavoriteButton(dynamic colors) {
    return IconButton(
      icon: SvgPicture.asset(
        _isFavorite ? Assets.favorite : Assets.unselectedFavorite,
        width: _iconSize,
        height: _iconSize,
      ),
      onPressed: _toggleFavorite,
    );
  }

  Widget _buildInfoButton() {
    return IconButton(
      icon: SvgPicture.asset(
        AppIcons.alertCircle,
        width: _iconSize,
        height: _iconSize,
      ),
      onPressed: _navigateToAboutStore,
    );
  }


  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  void _navigateToAboutStore() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AboutStore(),
      ),
    );
  }
}
