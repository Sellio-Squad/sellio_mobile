import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/domain/repositories/product_repository.dart';
import 'package:sellio_mobile/presentation/cubits/cart/cubit/cart_cubit.dart';
import 'package:sellio_mobile/presentation/cubits/cart/cubit/cart_state.dart';
import 'package:sellio_mobile/presentation/cubits/favorites/cubit/favorites_cubit.dart';
import 'package:sellio_mobile/presentation/cubits/favorites/cubit/favorites_state.dart';
import 'package:sellio_mobile/presentation/screens/product_details/cubit/product_details_cubit.dart';
import 'package:sellio_mobile/presentation/screens/product_details/cubit/product_details_state.dart';
import 'package:sellio_mobile/presentation/screens/product_details/widgets/product_counter_section.dart';
import 'package:sellio_mobile/presentation/screens/product_details/widgets/product_image_section.dart';
import 'package:sellio_mobile/presentation/screens/product_details/widgets/product_price_section.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(
        context.read<ProductRepository>(),
        context.read<CartCubit>(),
      )..loadProductDetails(productId),
      child: BlocListener<ProductDetailsCubit, ProductDetailsState>(
        listenWhen: (previous, current) => current is ProductDetailsAddToCartSuccess,
        listener: (context, state) {
          if (state is ProductDetailsAddToCartSuccess) {
            SellioSnackBar(
              isError: false,
              message: state.message,
              onCancelTap: () {},
            );
          }
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: context.theme.colors.surfaceLow,

            // ---------------- APP BAR ----------------
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                builder: (context, state) {
                  final title = (state is ProductDetailsLoaded) ? state.product.name : null;
                  return SellioAppBar(
                    showBackButton: true,
                    title: title,
                    actions: [productFavorite(context, productId)],
                  );
                },
              ),
            ),

            // ---------------- BODY ----------------
            body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              builder: (context, state) {
                if (state is ProductDetailsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ProductDetailsLoaded) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 100),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: constraints.maxHeight),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              productImagesSection(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildPriceAndCounterRow(context, state),
                                    _buildDescription(context, state),
                                  ],
                                ),
                              ),
                              _buildNoteTextField(context, state),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),

            // ---------------- BOTTOM BUTTON ----------------
            bottomNavigationBar: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              builder: (context, state) {
                if (state is! ProductDetailsLoaded) return const SizedBox();
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _buildAddToCartButton(context),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildPriceAndCounterRow(
    BuildContext context, ProductDetailsLoaded state) {
  return BlocBuilder<CartCubit, CartState>(
    builder: (context, cartState) {
      final productId = state.product.id;
      final count = cartState.productCounts[productId] ?? 0;

      return Row(
        children: [
          productPriceSection(context, state),
          const Expanded(child: Spacer()),
          productCounterSection(context, productId, count),
        ],
      );
    },
  );
}

Widget _buildDescription(
    BuildContext context, ProductDetailsLoaded state) {
  return Padding(
    padding: const EdgeInsets.only(top: 16),
    child: Text(
      state.product.description,
      style: context.theme.typography.textTheme.bodyMedium
          .copyWith(color: context.theme.colors.body),
    ),
  );
}

Widget _buildNoteTextField(
    BuildContext context, ProductDetailsLoaded state) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: SellioTextField(
      isParagraph: true,
      hintText: context.local.note_optional,
      controller: context.read<ProductDetailsCubit>().noteController,
    ),
  );
}

Widget _buildAddToCartButton(BuildContext context) {
  return BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
    listener: (context, state) {
      if (state is ProductDetailsAddToCartSuccess) {
        SellioSnackBar(
          isError: false,
          message: state.message,
          onCancelTap: () {},
        );
      }
    },
    builder: (context, state) {
      return SellioButton(
        text: context.local.add_to_cart,
        onTap: () => context.read<ProductDetailsCubit>().addToCart(),
        suffixSvgPath: AppImages.cartSmall,
      );
    },
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
