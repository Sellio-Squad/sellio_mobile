import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/localization/localization_service.dart';
import '../../../../core/design_system/widgets/cards/productHorizontalCard.dart';
import '../store_data_provider.dart';

class StoreProductsList extends StatefulWidget {
  final int categoryIndex;

  const StoreProductsList({
    super.key,
    required this.categoryIndex,
  });

  @override
  State<StoreProductsList> createState() => _StoreProductsListState();
}

class _StoreProductsListState extends State<StoreProductsList> {

  static const double _itemSpacing = 12.0;

  final Map<int, int> _productCounts = {};
  late final StoreDataProvider _dataProvider;
  late List<ProductData> _products;

  @override
  void initState() {
    super.initState();
    _dataProvider = StoreDataProvider();
    _loadProducts();
  }

  @override
  void didUpdateWidget(StoreProductsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryIndex != widget.categoryIndex) {
      _loadProducts();
    }
  }

  void _loadProducts() {
    setState(() {
      _products = _dataProvider.getProductsByCategory(widget.categoryIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_products.isEmpty) {
      return _buildEmptyState();
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        _buildProductItem,
        childCount: _products.length,
      ),
    );
  }

  Widget _buildEmptyState() {
    return SliverToBoxAdapter(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(context.local.no_products_available),
        ),
      ),
    );
  }

  Widget _buildProductItem(BuildContext context, int index) {
    final product = _products[index];
    final count = _getProductCount(product.id);

    return Padding(
      padding: const EdgeInsets.only(bottom: _itemSpacing),
      child: ProductHorizontalCard(
        imageUrl: product.imageUrl,
        title: product.title,
        description: product.description,
        price: product.price,
        originalPrice: product.originalPrice,
        count: count,
        onIncrement: () => _handleIncrement(product.id),
        onDecrement: () => _handleDecrement(product.id),
      ),
    );
  }


  int _getProductCount(int productId) {
    return _productCounts[productId] ?? 0;
  }


  void _handleIncrement(int productId) {
    setState(() {
      _productCounts[productId] = _getProductCount(productId) + 1;
    });
  }

  void _handleDecrement(int productId) {
    setState(() {
      final count = _getProductCount(productId);
      if (count > 0) {
        _productCounts[productId] = count - 1;
      }
    });
  }
}