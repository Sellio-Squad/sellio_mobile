import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/products/cubit/products_cubit.dart';
import '../../widgets/search_bar/search_widget.dart';

SliverToBoxAdapter buildSearchSection(BuildContext context) {
  return SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: SearchBarWithFilter(
        onFilterIconClicked: () {
          // TODO: Show filter dialog
        },
        onTextSubmitted: (text) {
          context.read<ProductsCubit>().searchProducts(text);
        },
      ),
    ),
  );
}