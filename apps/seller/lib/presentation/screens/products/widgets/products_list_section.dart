import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/product_list_cubit.dart';
import '../cubit/product_list_state.dart';
import 'products_empty_state.dart';
import 'products_loading_state.dart';
import 'seller_product_card.dart';
import 'delete_product_confirmation_sheet.dart';

class ProductsListSection extends StatelessWidget {
  const ProductsListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListCubit, ProductListState>(
      buildWhen: (previous, current) {
        if (previous is ProductListLoaded && current is ProductListLoaded) {
          return previous.products != current.products ||
              previous.isListLoading != current.isListLoading ||
              previous.isFiltered != current.isFiltered;
        }
        return previous.runtimeType != current.runtimeType;
      },
      builder: (context, state) {
        if (state is! ProductListLoaded) {
          return const SizedBox.shrink();
        }

        if (state.isListLoading) {
          return const ProductsLoadingState();
        }

        if (state.products.isEmpty) {
          return ProductsEmptyState(
            isFiltered: state.isFiltered,
            onRefresh: () => context.read<ProductListCubit>().refreshProducts(),
          );
        }

        return RefreshIndicator(
          onRefresh: () => context.read<ProductListCubit>().refreshProducts(),
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SellerProductCard(
                  product: product,
                  onEdit: () {},
                  onDelete: () {
                    _showDeleteConfirmation(context, product.id);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, String productId) {
    DeleteProductConfirmationSheet.show(
      context,
      onDelete: () {
        context.read<ProductListCubit>().deleteProduct(productId);
      },
    );
  }
}
