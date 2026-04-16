import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:sellio_mobile/presentation/screens/search/widgets/category_section.dart';
import '../../../../domain/entities/product.dart';
import '../../../../domain/entities/store.dart';
import '../cubit/search_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/presentation/cubits/cart/cubit/cart_cubit.dart';
import 'package:sellio_mobile/presentation/cubits/cart/cubit/cart_state.dart';
import '../../../widgets/customer_product_card.dart';

class SuccessSearch extends StatelessWidget {
  final SearchState state;

  const SuccessSearch({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CategorySection(),
        switch (state) {
          SearchProductsSuccess(:final products) =>
            GridProductsSection(products: products),
          SearchStoresSuccess(:final stores) => StoreList(stores: stores),
          _ => const SizedBox.shrink(),
        }
      ],
    );
  }
}

class StoreList extends StatelessWidget {
  final List<Store> stores;

  const StoreList({super.key, required this.stores});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stores.length,
      itemBuilder: (context, index) {
        final store = stores[index];
        return SellioStoreCard(
          imageUrl: store.coverImage,
          title: store.name,
        );
      },
    );
  }
}

class GridProductsSection extends StatelessWidget {
  final List<Product> products;
  const GridProductsSection({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        const cardWidth = 170.0;
        final crossAxisCount = (screenWidth / cardWidth).floor().clamp(1, 6);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 8,
            mainAxisSpacing: 12,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            final product = products[index];

            return CustomerProductCard(
              productId: product.id,
              imageUrl: product.images.isNotEmpty
                  ? product.images.first
                  : AppImages.cartProduct,
              title: product.title,
              formattedPrice: "${product.currency ?? ''}${product.minPrice}",
              rawPrice: double.tryParse(product.minPrice
                      .toString()
                      .replaceAll(RegExp(r'[^\d.]'), '')) ??
                  0.0,
              currency: product.currency ?? 'EGP',
              isFavorite: false,
              onTap: () {}, // No onTap found in previous version, just empty
              onFavoriteToggle: null,
            );
          },
        );
      },
    );
  }
}
