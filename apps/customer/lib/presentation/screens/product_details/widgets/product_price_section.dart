import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/presentation/screens/product_details/cubit/product_details_state.dart';
import 'package:sellio_mobile/presentation/utils/product_price_extensions.dart';

Widget productPriceSection(BuildContext context, ProductDetailsLoaded state) {
  final product = state.product;

  final double price = product.minPrice;
  final int? discount = int.tryParse(product.maxDiscount ?? '');
  final bool hasDiscount = discount != null && discount > 0;

  final List<Widget> priceWidgets = [];

  if (hasDiscount) {
    priceWidgets.add(
      Text(
        "\$${price.oldPrice(discount)}",
        style: context.theme.typography.textTheme.titleSmall.copyWith(
          color: context.theme.colors.hint,
          decoration: TextDecoration.lineThrough,
          decorationColor: context.theme.colors.hint,
        ),
      ),
    );
    priceWidgets.add(const SizedBox(width: 5));
  }

  priceWidgets.add(
    Text(
      "\$${price.toStringAsFixed(2)}",
      style: context.theme.typography.textTheme.titleSmall
          .copyWith(color: context.theme.colors.primary),
    ),
  );

  return Row(children: priceWidgets);
}
