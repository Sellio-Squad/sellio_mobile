import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/l10n/localization_service.dart';
import '../../../core/navigate/app_routes.dart';
import '../../../core/navigate/route_args.dart';
import '../../../di/injection_container.dart';
import '../../../domain/repository/product_repository.dart';
import '../../../domain/repository/search_repository.dart';
import '../../cubits/favorites/cubit/favorites_cubit.dart';
import '../../widgets/customer_product_card.dart';
import '../home/sections/trending_products/product_list_shimmer.dart';
import 'cubit/more_trending_cubit.dart';
import 'cubit/more_trending_state.dart';

class MoreTrendingScreen extends StatefulWidget {
  const MoreTrendingScreen({super.key});

  @override
  State<MoreTrendingScreen> createState() => _MoreTrendingScreenState();
}

class _MoreTrendingScreenState extends State<MoreTrendingScreen> {
  late final MoreTrendingCubit cubit;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    cubit = MoreTrendingCubit(
      sl<ProductRepository>(),
      sl<SearchRepository>(),
    );

    cubit.loadTrendingProducts();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      cubit.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: context.theme.colors.surfaceLow,
        appBar: SellioAppBar(
          title: context.local.trending_products,
          showBackButton: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: SellioSearchBar(
                hintText: context.local.search_your_favorite_items,
                controller: _searchController,
                onTextSubmitted: (query) {
                  context.read<MoreTrendingCubit>().searchProducts(query);
                },
              ),
            ),
            Expanded(
              child: _MoreTrendingContent(
                scrollController: _scrollController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoreTrendingContent extends StatelessWidget {
  final ScrollController scrollController;

  const _MoreTrendingContent({
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoreTrendingCubit, MoreTrendingState>(
      builder: (context, state) {
        if (state.isLoading && state.items.isEmpty) {
          return ProductsListShimmerVertical();
        }

        if (state.items.isEmpty && !state.isLoading) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 64,
                    color: context.theme.colors.title.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.local.no_products_available,
                    textAlign: TextAlign.center,
                    style: context.theme.typography.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          );
        }

        if (state.errorMessage != null && state.items.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.withValues(alpha: 0.6),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.errorMessage!,
                    textAlign: TextAlign.center,
                    style: context.theme.typography.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<MoreTrendingCubit>().refresh();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () {
            return context.read<MoreTrendingCubit>().refresh();
          },
          child: CustomScrollView(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              _buildProductsGrid(
                context,
                state,
              ),
              if (state.isLoadingMore)
                _buildLoadingMore(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductsGrid(
    BuildContext context,
    MoreTrendingState state,
  ) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      sliver: SliverLayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.crossAxisExtent;
          const cardWidth = 170.0;

          final crossAxisCount =
              (screenWidth / cardWidth).floor().clamp(1, 6);

          return SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final product = state.items[index];

                final imageUrl = product.images.isNotEmpty
                    ? product.images.first
                    : AppImages.cartProduct;

                return CustomerProductCard(
                  cardKey: ValueKey(product.id),
                  productId: product.id,
                  imageUrl: imageUrl,
                  title: product.title,
                  formattedPrice: product.minPrice.toString(),
                  isFavorite: product.isFavorite,
                  onFavoriteToggle: () {
                    context.read<FavoritesCubit>().toggleFavorite(
                          product.id,
                          FavoriteType.product,
                        );
                  },
                  onTap: () {
                    GoRouter.of(context).push(
                      AppRoutes.productDetails.path,
                      extra: ProductDetailsArgs(
                        productId: product.id,
                      ),
                    );
                  },
                );
              },
              childCount: state.items.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 8,
              mainAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingMore() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
