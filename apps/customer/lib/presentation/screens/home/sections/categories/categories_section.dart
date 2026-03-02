import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/presentation/screens/home/sections/categories/cubit/categories_cubit.dart';
import 'package:sellio_mobile/presentation/screens/home/sections/categories/cubit/categories_state.dart';
import 'package:shimmer/shimmer.dart';

import 'all_categories_bottom_sheet.dart';
import 'category_item.dart';
import 'model/Catgeory_model.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final colors = theme.colors;
    final SellioTextTheme themeText = context.theme.typography.textTheme;

    return SliverToBoxAdapter(
      child: BlocConsumer<CategoriesCubit, CategoriesState>(
        listener: (context, state) {
          if (state is HomeCategoriesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is HomeCategoriesLoading) {
            return const CategoriesShimmer();
          }

          if (state is HomeCategoriesError) {
            return _ErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<CategoriesCubit>().fetchCategories();
              },
            );
          }

          if (state is HomeCategoriesLoaded) {
            final categories = state.categories;

            if (categories.isEmpty) {
              return const SizedBox.shrink();
            }

            const maxVisible = 7;
            final showMore = categories.length > maxVisible;
            final visibleCategories =
                showMore ? categories.take(maxVisible).toList() : categories;

            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colors.stroke,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: visibleCategories.length + (showMore ? 1 : 0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) {
                    if (showMore && index == visibleCategories.length) {
                      return CategoryItem.more(
                        onTap: () {
                          _showAllCategories(context, categories);
                        },
                      );
                    }

                    return CategoryItem(
                      category: visibleCategories[index],
                      onTap: () {
                        // Handle category tap
                      },
                    );
                  },
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showAllCategories(
      BuildContext context, List<HomeCategoryModel> categories) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AllCategoriesBottomSheet(categories: categories),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorWidget({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red.shade200),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red.shade400, size: 48),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red.shade700, fontSize: 14),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = SellioTheme.of(context).colors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Shimmer.fromColors(
          baseColor: colors.surface,
          highlightColor: colors.surfaceLow,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 8,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (context, index) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 48,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
