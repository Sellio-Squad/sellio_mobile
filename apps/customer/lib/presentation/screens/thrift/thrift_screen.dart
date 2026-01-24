import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

import '../../../../domain/repositories/category_repository.dart';
import '../../../../domain/repositories/product_repository.dart';
import '../../../core/navigate/app_routes.dart';
import '../../../core/navigate/route_args.dart';
import '../../cubits/cart/cubit/cart_cubit.dart';
import '../../cubits/favorites/cubit/favorites_cubit.dart';
import 'cubit/thrift_products_cubit.dart';
import 'cubit/thrift_products_state.dart';
import 'widgets/category_tabs.dart';

class ThriftScreen extends StatefulWidget {
  const ThriftScreen({super.key});

  @override
  State<ThriftScreen> createState() => _ThriftScreenState();
}

class _ThriftScreenState extends State<ThriftScreen> {
  late ThriftProductsCubit cubit;
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
}

class ThriftContent extends StatelessWidget {
  final ScrollController scrollController;

  const ThriftContent({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThriftProductsCubit, ThriftProductsState>(
      builder: (context, state) {
        if (state.isLoading && state.items.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: () => context.read<ThriftProductsCubit>().refresh(),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              _buildCategoryTabs(context, state),
              _buildProductsGrid(context, state),
              if (state.isLoadingMore) _buildLoadingMore(),
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
        icon: AppImages.allCategories,
      ),
      ...state.categories.map((c) => CategoryTabData(
            id: c.id,
            name: c.name,
            icon: _mapCategoryIcon(c.name),
          )),
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

  String _mapCategoryIcon(String name) {
    switch (name.toLowerCase()) {
      case 'food':
        return AppImages.food;
      case 'drinks':
        return AppImages.drinks;
      case 'clothes':
        return AppImages.clothes;
      default:
        return AppImages.allCategories;
    }
  }
  Widget _buildProductsGrid(BuildContext context, ThriftProductsState state) {
    if (state.items.isEmpty) {
      return SliverFillRemaining(
        child: Center(child: Text(context.local.no_products_found)),
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
                final productId = product.id;

                final cart = context.watch<CartCubit>();
                final favorites = context.watch<FavoritesCubit>();

                final count = cart.state.productCounts[productId] ?? 0;
                final isFavorite = favorites.state.productIds.contains(productId);

                final imageUrl =
                    product.images.isNotEmpty ? product.images.first : '';

                return SellioProductVerticalCard(
                  key: ValueKey(productId),
                  productId: productId,
                  imageUrl: imageUrl,
                  title: product.title,
                  price: product.price.toString(),
                  isFavorite: isFavorite,
                  onFavoriteToggle: () async {
                    // Pessimistic update: wait for API response before updating UI
                    final success = await context.read<FavoritesCubit>().toggleProductFavorite(productId);
                    return success;
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
              childAspectRatio: 160 / 272,
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
