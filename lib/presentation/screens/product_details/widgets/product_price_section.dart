import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/presentation/screens/product_details/cubit/product_details_state.dart';
import 'package:sellio_mobile/presentation/utils/product_price_extensions.dart';

Widget productPriceSection(BuildContext context, ProductDetailsLoaded state) {
  final product = state.product;

  final double price = product.price;
  final String discountString = product.discount ?? '';
  final int? discount = int.tryParse(discountString);

  final bool hasDiscount = discount != null && discount > 0;

  return Row(
    children: [
      if (hasDiscount)
        Text(
          "\$${price.oldPrice(discount)}",
          style: context.theme.typography.textTheme.titleSmall.copyWith(
            color: context.theme.colors.hint,
            decoration: TextDecoration.lineThrough,
            decorationColor: context.theme.colors.hint,
          ),
        ),
      if (hasDiscount)
        const SizedBox(width: 5),
      Text(
        "\$${price.toStringAsFixed(2)}",
        style: context.theme.typography.textTheme.titleSmall
            .copyWith(color: context.theme.colors.primary),
      ),
    ],
  );
}
