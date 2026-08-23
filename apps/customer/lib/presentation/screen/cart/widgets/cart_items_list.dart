import 'package:design_system/design_system.dart';
import 'package:design_system/widgets/dashed_divider.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigate/navigation_extensions.dart';
import '../../../../core/navigate/route_args.dart';
import '../../../../domain/entities/cart.dart';
import '../constants/cart_constants.dart';

class CartItemsList extends StatelessWidget {
  final List<CartItem> items;
  final Map<String, int> productCounts;

  final void Function(String productId) onIncrement;
  final void Function(String productId) onDecrement;
  final void Function(String itemId) onRemove;

  const CartItemsList({
    super.key,
    required this.items,
    required this.productCounts,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: CartConstants.itemSpacing,
          horizontal: CartConstants.dividerHorizontalPadding,
        ),
        child: const DashedDivider(),
      ),
      itemBuilder: (context, index) {
        return _buildCartItem(
          context,
          items[index],
        );
      },
    );
  }

  Widget _buildCartItem(
      BuildContext context,
      CartItem item,
      ) {
    final quantity =
        productCounts[item.productId] ?? item.quantity;

    return SizedBox(
      height: CartConstants.cardHeight,
      child: SellioProductHorizontalCard(
        onTap: () => _navigateToProductDetails(
          context,
          item.productId,
        ),

        imageUrl: item.productImage,

        title: item.productTitle,

        price: item.unitPrice.toStringAsFixed(2),

        originalPrice: null,

        count: quantity,

        onIncrement: () {
          onIncrement(item.productId);
        },

        onDecrement: () {
          onDecrement(item.productId);
        },

        onRemove: () {
          // DELETE /v1/cart/items/{itemId}
          onRemove(item.id);
        },
      ),
    );
  }

  void _navigateToProductDetails(
      BuildContext context,
      String productId,
      ) {
    context.navigator.pushProductDetails(
      ProductDetailsArgs(
        productId: productId,
      ),
    );
  }
}