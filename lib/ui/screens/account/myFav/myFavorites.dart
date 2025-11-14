import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import 'package:sellio_mobile/core/design_system/widgets/chip_category.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import '../../../../core/design_system/themes/sellio_theme.dart';
import 'models/favorite_product_model.dart';
import 'models/favorite_store_model.dart';
import 'widgets/products_grid_section.dart';
import 'widgets/stores_section.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _selectedTabIndex = 0;
  final List<String> _tabs = ['Products', 'Stores'];

  final List<FavoriteProduct> _favoriteProducts = [
    FavoriteProduct(
      id: 0,
      imageUrl: 'assets/images/product_3.webp',
      title: 'Birthday Cake with Bows',
      price: '\$12.99',
      isFavorite: false,
    ),
    FavoriteProduct(
      id: 1,
      imageUrl: 'assets/images/product_3.webp',
      title: 'Berry Cake',
      price: '\$12.99',
      isFavorite: true,
    ),
  ];
  final List<FavoriteStore> _favoriteStores = [
    FavoriteStore(
      id: "0",
      name: 'Sweet Treats Bakery',
      imageUrl: 'assets/images/product_3.webp',
      isFavorite: true,
    ),
    FavoriteStore(
      id: "1",
      name: 'Cake & Coffee House',
      imageUrl: 'assets/images/product_3.webp',
      isFavorite: true,
    ),
  ];

  final Map<int, int> _productCounts = {};

  void _incrementProduct(int productId) {
    setState(() => _productCounts[productId] = (_productCounts[productId] ?? 0) + 1);
  }

  void _decrementProduct(int productId) {
    setState(() {
      final count = _productCounts[productId] ?? 0;
      if (count > 0) _productCounts[productId] = count - 1;
    });
  }
  void _toggleFavoriteProduct(int productId) {
    setState(() {
      final index = _favoriteProducts.indexWhere((p) => p.id == productId);
      if (index != -1) {
        _favoriteProducts[index].isFavorite = !_favoriteProducts[index].isFavorite;
      }
    });
  }
  void _toggleFavoriteStore(int storeId) {
    setState(() {
      final index = _favoriteStores.indexWhere((s) => s.id == storeId);
      if (index != -1) {
        _favoriteStores[index].isFavorite = !_favoriteStores[index].isFavorite;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colorScheme = theme.colors;

    return Scaffold(
      backgroundColor: colorScheme.surfaceLow,
      appBar: SellioAppBar(title: context.local.favorites, showBackButton: true),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ✅ Category Tabs
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Row(
                  children: List.generate(_tabs.length, (index) {
                    final isSelected = _selectedTabIndex == index;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: ChipCategory(
                        label: _tabs[index],
                        assetIcon: index == 0 ? Assets.product : Assets.store,
                        selected: isSelected,
                        onTap: () => setState(() => _selectedTabIndex = index),
                      ),
                    );
                  }),
                ),
              ),
            ),

            // ✅ Products Tab
            if (_selectedTabIndex == 0)
              ProductsGridSection(
                favoriteProducts: _favoriteProducts,
                productCounts: _productCounts,
                onIncrement: _incrementProduct,
                onDecrement: _decrementProduct,
                onToggleFavorite: _toggleFavoriteProduct,
              )
            else
              StoresSection(
                stores: _favoriteStores,
                onToggleFavorite: _toggleFavoriteStore,
              ),
          ],
        ),
      ),
    );
  }
}
