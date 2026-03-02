import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_list_shimmer.dart';
import 'cubit/home_trending_products_cubit.dart';
import 'cubit/home_trending_products_state.dart';
import 'widgets/products_list.dart';

class TrendingProductsSection extends StatelessWidget {
  const TrendingProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTrendingProductsCubit, HomeTrendingProductsState>(
      listener: (context, state) {
        if (state is HomeTrendingProductsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }

        if (state is HomeTrendingProductsSearching) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Searching for "${state.query}"...'),
              duration: const Duration(seconds: 1),
              backgroundColor: Colors.blue,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is HomeTrendingProductsLoading ||
            state is HomeTrendingProductsSearching) {
          return const SliverToBoxAdapter(child: ProductsListShimmer());
        }

        if (state is HomeTrendingProductsError) {
          return SliverToBoxAdapter(
            child: _ErrorWidget(
              message: state.message,
              onRetry: () =>
                  context.read<HomeTrendingProductsCubit>().refreshProducts(),
            ),
          );
        }

        if (state is! HomeTrendingProductsLoaded) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        return SliverToBoxAdapter(
          child: ProductsList(
            products: state.products,
            searchQuery: state.searchQuery,
          ),
        );
      },
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorWidget({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 272,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
