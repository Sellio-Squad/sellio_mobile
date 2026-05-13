import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:design_system/design_system.dart';
import '../../../core/localization/l10n/localization_service.dart';
import '../../../core/navigate/app_routes.dart';
import '../../../core/navigate/route_args.dart';
import '../../../domain/repositories/product_repository.dart';
import '../../cubits/favorites/cubit/favorites_cubit.dart';
import 'cubit/more_trending_cubit.dart';
import 'cubit/more_trending_state.dart';
import '../../widgets/customer_product_card.dart';

class MoreTrendingScreen extends StatefulWidget {
  const MoreTrendingScreen({super.key});

  @override
  State<MoreTrendingScreen> createState() => _MoreTrendingScreenState();
}

class _MoreTrendingScreenState extends State<MoreTrendingScreen> {
  late MoreTrendingCubit cubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    cubit = MoreTrendingCubit(context.read<ProductRepository>());
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
        body: _MoreTrendingContent(scrollController: _scrollController),
      ),
    );
  }
}

class _MoreTrendingContent extends StatelessWidget {
  final ScrollController scrollController;

  const _MoreTrendingContent({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoreTrendingCubit, MoreTrendingState>(
      builder: (context, state) {
        if (state.isLoading && state.items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.items.isEmpty && !state.isLoading) {
          return Center(
            child: Text(
              context.local.no_products_available,
              style: context.theme.typography.textTheme.bodyMedium,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => context.read<MoreTrendingCubit>().refresh(),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              _buildProductsGrid(context, state),
              if (state.isLoadingMore) _buildLoadingMore(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductsGrid(BuildContext context, MoreTrendingState state) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      sliver: SliverLayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.crossAxisExtent;
          const cardWidth = 170.0;
          final crossAxisCount = (screenWidth / cardWidth).floor().clamp(1, 6);

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
                  rawPrice: double.tryParse(product.minPrice
                          .toString()
                          .replaceAll(RegExp(r'[^\d.]'), '')) ??
                      0.0,
                  currency: 'EGP',
                  isFavorite: product.isFavorite,
                  onFavoriteToggle: () {
                    context
                        .read<FavoritesCubit>()
                        .toggleFavorite(product.id, FavoriteType.product);
                  },
                  onTap: () {
                    GoRouter.of(context).push(
                      AppRoutes.productDetails.path,
                      extra: ProductDetailsArgs(productId: product.id),
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
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
