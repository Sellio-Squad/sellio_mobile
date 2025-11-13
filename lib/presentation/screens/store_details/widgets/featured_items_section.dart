import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/widgets/cards/product_vertical_card.dart';
import 'package:sellio_mobile/core/design_system/widgets/section_header.dart';
import '../../../../domain/entities/product.dart';
import 'package:sellio_mobile/core/localization/localization_service.dart';

class FeaturedItemsSection extends StatefulWidget {
  final List<Product> products;

  const FeaturedItemsSection({super.key, required this.products});

  @override
  State<FeaturedItemsSection> createState() => _FeaturedItemsSectionState();
}

class _FeaturedItemsSectionState extends State<FeaturedItemsSection> {
  final Map<String, int> _productCounts = {};

  void _incrementProduct(String productId) {
    setState(() {
      _productCounts[productId] = (_productCounts[productId] ?? 0) + 1;
    });
  }

  void _decrementProduct(String productId) {
    setState(() {
      final count = _productCounts[productId] ?? 0;
      if (count > 0) _productCounts[productId] = count - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.products.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SectionHeader(
            title: context.local.featured_items,
            trailing: SvgPicture.asset(
              Assets.arrowRight,
              width: 20,
              height: 20,
            ),
          ),
        ),
        SizedBox(
          height: 272,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: widget.products.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final product = widget.products[index];
              final count = _productCounts[product.id] ?? 0;

              // Log the first image of each product
              if (product.images.isNotEmpty) {
                debugPrint('Product ${product.id} image: ${product.images.first}');
              } else {
                debugPrint('Product ${product.id} has no images.');
              }

              return SizedBox(
                width: 160,
                child: ProductVerticalCard(
                  imageUrl: product.images.isNotEmpty ? product.images.first : '',
                  title: product.name,
                  price: '\$${product.price}',
                  count: count,
                  onIncrement: () => _incrementProduct(product.id),
                  onDecrement: () => _decrementProduct(product.id),
                  onFavorite: () {},
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}