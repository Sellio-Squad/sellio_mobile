import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/presentation/screens/home/sections/categories/cubit/categories_cubit.dart';
import 'package:sellio_mobile/presentation/screens/home/sections/categories/cubit/categories_state.dart';

import 'category_item.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
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
          return const SliverToBoxAdapter(
            child: CategoriesShimmer(),
          );
        }

        if (state is HomeCategoriesError) {
          return SliverToBoxAdapter(
            child: _ErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<CategoriesCubit>().fetchCategories();
              },
            ),
          );
        }

        if (state is HomeCategoriesLoaded) {
          final categories = state.categories;

          if (categories.isEmpty) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }

          const maxVisible = 7;
          final showMore = categories.length >= 8;
          final visibleCategories =
              showMore ? categories.take(maxVisible).toList() : categories;

          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (showMore && index == visibleCategories.length) {
                    return CategoryItem.more(
                      onTap: () {},
                    );
                  }

                  return CategoryItem(
                    category: visibleCategories[index],
                    onTap: () {},
                  );
                },
                childCount: visibleCategories.length + (showMore ? 1 : 0),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.9,
              ),
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
