import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/design_system/constants/app_images.dart';
import '../../../../../../core/localization/l10n/localization_service.dart';
import 'cubit/home_categories_cubit.dart';
import 'cubit/home_categories_state.dart';
import 'widgets/category_tabs.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCategoriesCubit, HomeCategoriesState>(
      listener: (context, state) {
        // Handle side effects
        if (state is HomeCategoriesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              action: SnackBarAction(
                label: 'Retry',
                textColor: Colors.white,
                onPressed: () {
                  context.read<HomeCategoriesCubit>().loadCategories();
                },
              ),
            ),
          );
        }
      },
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

        final tabs = [
          CategoryTabData(
            id: "all",
            name: context.local.all,
            icon: AppImages.allCategories,
          ),
          ...state.categories.map((cp) => CategoryTabData(
                id: cp.category.id,
                name: cp.category.name,
                icon: cp.icon,
              )),
        ];

        return SliverToBoxAdapter(
          child: CategoryTabs(
            categories: tabs,
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