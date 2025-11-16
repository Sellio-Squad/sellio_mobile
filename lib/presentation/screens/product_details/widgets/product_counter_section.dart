import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/design_system/constants/app_images.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/presentation/cubits/cart/cubit/cart_cubit.dart';

Widget productCounterSection(
    BuildContext context, String productId, int count) {
  return Row(
    children: [
      GestureDetector(
        onTap: () => context.read<CartCubit>().decrementProduct(productId),
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: context.theme.colors.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppImages.remove,
                width: 16,
                height: 16,
                colorFilter: ColorFilter.mode(
                  context.theme.colors.body,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
        child: Text(
          count < 10 ? '0$count' : '$count',
          style: context.theme.typography.textTheme.labelMedium
              .copyWith(color: context.theme.colors.title),
        ),
      ),
      GestureDetector(
        onTap: () => context.read<CartCubit>().incrementProduct(productId),
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: context.theme.colors.primaryVariant,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppImages.add,
                width: 16,
                height: 16,
                colorFilter: ColorFilter.mode(
                  context.theme.colors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}