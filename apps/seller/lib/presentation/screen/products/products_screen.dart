import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller/di/injection_container.dart';
import 'package:seller/core/localization/l10n/localization_service.dart';
import 'cubit/product_list_cubit.dart';
import 'cubit/product_list_state.dart';
import 'widgets/products_body.dart';
import 'widgets/products_empty_state.dart';
import 'widgets/products_error_state.dart';
import 'widgets/products_loading_state.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductListCubit>()..loadProducts(),
      child: Scaffold(
        backgroundColor: context.theme.colors.surfaceLow,
        appBar: SellioAppBar(
          title: context.local.my_products,
          showBackButton: false,
        ),
        body: BlocBuilder<ProductListCubit, ProductListState>(
          buildWhen: (previous, current) {
            if (previous.runtimeType != current.runtimeType) {
              return true;
            }
            if (previous is ProductListLoaded && current is ProductListLoaded) {
              return previous.hasAnyProducts != current.hasAnyProducts;
            }
            return false;
          },
          builder: (context, state) {
            return switch (state) {
              ProductListInitial() => const ProductsLoadingState(),
              ProductListLoading() => const ProductsLoadingState(),
              ProductListLoaded(:final hasAnyProducts) =>
                hasAnyProducts ? const ProductsBody() : ProductsEmptyState(
                    isFiltered: false,
                    onRefresh: () =>
                        context.read<ProductListCubit>().loadProducts(),
                  ),
              ProductListError(:final message) => ProductsErrorState(
                  message: message,
                  onRetry: () =>
                      context.read<ProductListCubit>().loadProducts(),
                ),
            };
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: context.theme.colors.primary,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
