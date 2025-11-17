import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/home_categories_cubit.dart';
import 'cubit/home_categories_state.dart';
import 'widgets/category_tabs.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCategoriesCubit, HomeCategoriesState>(
      builder: (context, state) {
        if (state is HomeCategoriesLoading) {
          return const SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (state is! HomeCategoriesLoaded || state.categories.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        return SliverToBoxAdapter(
          child: CategoryTabs(
            categories: state.categories
                .map((cp) => CategoryTabData(
              id: cp.category.id,
              name: cp.category.name,
              icon: cp.icon,
            ))
                .toList(),
            selectedIndex: state.selectedIndex,
            onCategorySelected: (index) {
              context.read<HomeCategoriesCubit>().selectCategory(index);
            },
          ),
        );
      },
    );
  }
}