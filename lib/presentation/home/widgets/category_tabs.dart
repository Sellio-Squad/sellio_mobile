import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/design_system/widgets/chip_category.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        if (previous is HomeLoaded && current is HomeLoaded) {
          return previous.categories != current.categories ||
              previous.selectedCategoryIndex != current.selectedCategoryIndex ||
              previous.isCategoriesLoading != current.isCategoriesLoading;
        }
        return true;
      },
      builder: (context, state) {
        if (state is! HomeLoaded) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        if (state.isCategoriesLoading) {
          return const SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (state.categories.isEmpty) {
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
                final isSelected = state.selectedCategoryIndex == index;

                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ChipCategory(
                    label: categoryPresentation.category.name,
                    assetIcon: categoryPresentation.icon,
                    selected: isSelected,
                    onTap: () {
                      context.read<HomeCubit>().selectCategory(index);
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}