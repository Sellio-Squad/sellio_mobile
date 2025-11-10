import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/categories/cubit/home_categories_cubit.dart';
import 'cubits/categories/cubit/home_categories_state.dart';
import 'cubits/products/cubit/products_cubit.dart';

class HomeListeners extends StatelessWidget {
  final Widget child;

  const HomeListeners({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeCategoriesCubit, HomeCategoriesState>(
          listener: _onCategoryChanged,
        ),
      ],
      child: child,
    );
  }

  void _onCategoryChanged(BuildContext context, HomeCategoriesState state) {
    if (state is HomeCategoriesLoaded) {
      final productsCubit = context.read<ProductsCubit>();

      if (state.selectedIndex == 0) {
        productsCubit.loadTrendingProducts();
      } else if (state.selectedIndex < state.categories.length) {
        final categoryId = state.categories[state.selectedIndex].category.id;
        productsCubit.loadProductsByCategory(categoryId);
      }
    }
  }
}