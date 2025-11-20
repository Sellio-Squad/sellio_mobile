import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/presentation/screens/product_details/cubit/product_details_state.dart';

Widget productPriceSection(BuildContext context, ProductDetailsLoading state) {
  final product = state.product;
  final hasDiscount =
      product?.discount != null && product?.discount?.isNotEmpty == true;

  return Row(
    children: [
      if (hasDiscount)
        Text(
          // '\$${Product.discount}',
          '${product?.discount}',
          style: context.theme.typography.textTheme.titleSmall.copyWith(
            color: context.theme.colors.hint,
            decoration: TextDecoration.lineThrough,
            decorationColor: context.theme.colors.hint,
          ),
        ),
      Padding(
        padding: const EdgeInsets.only(left: 3),
        child: Text(
          '${product?.price}',
          style: context.theme.typography.textTheme.titleSmall
              .copyWith(color: context.theme.colors.primary),
        ),
      ),
    ],
  );
}