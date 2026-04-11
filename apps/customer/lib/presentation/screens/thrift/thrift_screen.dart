import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/core/navigate/navigation_extensions.dart';
import 'package:sellio_mobile/presentation/screens/thrift/widgets/thrift_screen_loadingMore_shimmer.dart';
import 'package:sellio_mobile/presentation/screens/thrift/widgets/thrift_screen_shimmer.dart';
import '../../../../domain/repositories/category_repository.dart';
import '../../../../domain/repositories/product_repository.dart';
import '../../../core/navigate/app_routes.dart';
import '../../../core/navigate/route_args.dart';
import '../../cubits/favorites/cubit/favorites_cubit.dart';
import '../../cubits/favorites/cubit/favorites_state.dart';
import 'cubit/thrift_products_cubit.dart';
import 'cubit/thrift_products_state.dart';
import 'widgets/category_tabs.dart';

class ThriftScreen extends StatefulWidget {
  const ThriftScreen({super.key});

  @override
  State<ThriftScreen> createState() => _ThriftScreenState();
}

class _ThriftScreenState extends State<ThriftScreen> {
  late final ThriftProductsCubit cubit;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    cubit = ThriftProductsCubit(
      context.read<ProductRepository>(),
      context.read<CategoryRepository>(),
    );

    cubit.loadCategories();
    cubit.loadThriftProducts();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      cubit.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: colors.surfaceLow,
        appBar: SellioAppBar(title: context.local.thrift),
        body: ThriftContent(scrollController: _scrollController),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    cubit.close();
    super.dispose();
  }
}

class ThriftContent extends StatelessWidget {
  final ScrollController scrollController;

  const ThriftContent({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThriftProductsCubit, ThriftProductsState>(
      builder: (context, state) {
        if (state.isLoading && state.items.isEmpty) {
          return const ThriftScreenLoadingMoreShimmer();
        }

        return RefreshIndicator(
          onRefresh: () => context.read<ThriftProductsCubit>().refresh(),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              _buildCategoryTabs(context, state),
              _buildProductsGrid(context, state),
              if (state.isLoadingMore) const ThriftLoadingMoreShimmer(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryTabs(BuildContext context, ThriftProductsState state) {
    final cubit = context.read<ThriftProductsCubit>();

    final tabs = [
      CategoryTabData(
        id: "all",
        name: context.local.all,
      ),
      ...state.categories.map(
            (c) => CategoryTabData(
          id: c.id,
          name: c.name,
        ),
      ),
    ];

    final selectedIndex =
    tabs.indexWhere((t) => t.id == state.selectedCategoryId);

    return SliverToBoxAdapter(
      child: CategoryTabs(
        categories: tabs,
        selectedIndex: selectedIndex >= 0 ? selectedIndex : 0,
        onCategorySelected: (index) {
          final selectedId = tabs[index].id;
          cubit.selectCategory(selectedId);
        },
      ),
    );
  }

  Widget _buildProductsGrid(BuildContext context, ThriftProductsState state) {
    if (state.items.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: EmptySection(
            icon: AppImages.noOrderHistory,
            title: context.local.no_products_found,
            description: context.local.you_can_dicover_more_products,
            buttonText: context.local.start_exploring_more,
            color: context.theme.colors.purpleVariant,
            onTap: () => context.navigator.goToHome(),
          ),
        ),
      );
    }

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

                return BlocBuilder<FavoritesCubit, FavoritesState>(
                  builder: (context, favState) {
                    bool isFavorite = product.isFavorite;
                    if (favState is FavoritesLoaded) {
                      isFavorite =
                          favState.favoriteProductIds.contains(product.id);
                    }

                    return SellioProductVerticalCard(
                      key: ValueKey(product.id),
                      productId: product.id,
                      imageUrl: product.images.isNotEmpty
                          ? product.images.first
                          : '',
                      title: product.title,
                      price: product.minPrice.toString(),
                      isFavorite: isFavorite,
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
                );
              },
              childCount: state.items.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 8,
              mainAxisSpacing: 12,
              childAspectRatio: 160 / 272,
            ),
          );
        },
      ),
    );
  }
}
