import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/design_system/widgets/chip_category.dart';
import '../../../../cubits/categories/cubit/categories_cubit.dart';
import '../../../../cubits/categories/cubit/categories_state.dart';

Widget buildCategoryTabs() {
  return BlocBuilder<CategoriesCubit, CategoriesState>(
    builder: (context, state) {
      if (state is CategoriesLoading) {
        return const SliverToBoxAdapter(
          child: SizedBox(
            height: 40,
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      }

      if (state is! CategoriesLoaded || state.categories.isEmpty) {
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      }

      return SliverToBoxAdapter(
        child: SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              final categoryPresentation = state.categories[index];
              final isSelected = state.selectedIndex == index;

              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: ChipCategory(
                  label: categoryPresentation.category.name,
                  assetIcon: categoryPresentation.icon,
                  selected: isSelected,
                  onTap: () => context.read<CategoriesCubit>().selectCategory(index),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}