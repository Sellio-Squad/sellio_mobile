import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/constants/app_images.dart';
import 'package:sellio_mobile/core/design_system/constants/app_strings.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/sellio_button.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_snack_bar.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_text_field.dart';
import 'package:sellio_mobile/domain/repositories/product_repository.dart';
import 'package:sellio_mobile/presentation/cubits/cart/cubit/cart_cubit.dart';
import 'package:sellio_mobile/presentation/cubits/cart/cubit/cart_state.dart';
import 'package:sellio_mobile/presentation/cubits/favorites/cubit/favorites_cubit.dart';
import 'package:sellio_mobile/presentation/cubits/favorites/cubit/favorites_state.dart';
import 'package:sellio_mobile/presentation/screens/product_details/cubit/product_details_cubit.dart';
import 'package:sellio_mobile/presentation/screens/product_details/cubit/product_details_state.dart';
import 'package:sellio_mobile/presentation/screens/product_details/product_details_listeners.dart';
import 'package:sellio_mobile/presentation/screens/product_details/widgets/product_counter_section.dart';
import 'package:sellio_mobile/presentation/screens/product_details/widgets/product_image_section.dart';
import 'package:sellio_mobile/presentation/screens/product_details/widgets/product_price_section.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  const ProductDetailsScreen({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return ProductDetailsListener(
      child: BlocProvider(
        create: (context) => ProductDetailsCubit(
          context.read<ProductRepository>(),
          context.read<CartCubit>(),
        )..loadProductDetails(productId),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: context.theme.colors.surfaceLow,
            appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56), // or kToolbarHeight
          child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
            builder: (context, state) {
              final title = (state is ProductDetailsLoading)
                  ? state.product?.name: null;

              return SellioAppBar(
                showBackButton: true,
                title: title,
                actions: [
                  productFavorite(context, productId),
                ],
              );
            },
          ),
        ),

        body: Column(
              children: [
                productImagesSection(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildPriceAndCounterRow(context),
                      _buildDescription(context),
                    ],
                  ),
                ),
                _buildNoteTextField(context),
              ],
            ),
            bottomNavigationBar: _buildAddToCartButton(context),
          ),
        ),
      ),
    );
  }
}

Widget _buildPriceAndCounterRow(BuildContext context) {
  return BlocBuilder<CartCubit, CartState>(
    builder: (context, cartState) {
      return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, productState) {
          if (productState is! ProductDetailsLoading) return const SizedBox();

          final productId = productState.product?.id;
          final count = cartState.productCounts[productId] ?? 0;

          return Row(
            children: [
              productPriceSection(context, productState),
              const Expanded(child: Spacer()),
              productCounterSection(context, productId!, count),
            ],
          );
        },
      );
    },
  );
}

Widget _buildDescription(BuildContext context) {
  return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
    builder: (context, state) {
      if (state is! ProductDetailsLoading) return const SizedBox();

      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(
          state.product!.description,
          style: context.theme.typography.textTheme.bodyMedium
              .copyWith(color: context.theme.colors.body),
        ),
      );
    },
  );
}

Widget _buildNoteTextField(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        if (state is! ProductDetailsLoading) return const SizedBox();

        return SellioTextField(
          isParagraph: true,
          hintText: AppStrings.noteOptional,
          controller: context.read<ProductDetailsCubit>().noteController,
        );
      },
    ),
  );
}

Widget _buildAddToCartButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
    child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
      listener: (context, state) {
        if (state is ProductDetailsAddToCartSuccess &&
            state.cartMessage != null) {
          SellioSnackBar(
            isError: false,
            message: state.cartMessage!,
            onCancelTap: () {
              //TODO
            },
          );
        }
      },
      builder: (context, state) {
        return SellioButton(
          text: AppStrings.addToCart,
          onTap: () => context.read<ProductDetailsCubit>().addToCart(),
          suffixSvgPath: AppImages.cart,
        );
      },
    ),
  );
}

Widget productFavorite(BuildContext context, String productId) {
  return BlocBuilder<FavoritesCubit, FavoritesState>(
    builder: (context, favoritesState) {
      final isFavorite = favoritesState.productIds.contains(productId);

      return IconButton(
        icon: SvgPicture.asset(
          isFavorite ? AppImages.favorite : AppImages.unselectedFavorite,
        ),
        onPressed: () async {
          await context.read<FavoritesCubit>().toggleProductFavorite(productId);
        },
      );
    },
  );
}