import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/domain/entities/product.dart';
import 'package:sellio_mobile/presentation/screens/category_details/cubit/category_details_cubit.dart';
import 'package:sellio_mobile/presentation/screens/category_details/cubit/category_details_state.dart';
import '../../../di/injection_container.dart';
import '../../../domain/repositories/category_details_repository.dart';
import '../home/utils/home_navigation.dart';
import '../../widgets/customer_product_card.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;

  const CategoryDetailsScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryDetailsCubit(
        repository: sl<CategoryDetailsRepository>(),
        categoryId: categoryId,
      )..initialize(),
      child: _CategoryDetailsView(categoryName: categoryName),
    );
  }
}

class _CategoryDetailsView extends StatelessWidget {
  final String categoryName;

  const _CategoryDetailsView({required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final colors = SellioTheme.of(context).colors;

    return Scaffold(
      backgroundColor: colors.surfaceLow,
      appBar: SellioAppBar(
        title: categoryName,
        showBackButton: true,
      ),
      body: BlocBuilder<CategoryDetailsCubit, CategoryDetailsState>(
        builder: (context, state) {
          if (state is CategoryDetailsLoading) {
            return const _LoadingView();
          }

          if (state is CategoryDetailsError) {
            return _ErrorView(
              message: state.message,
              onRetry: () => context.read<CategoryDetailsCubit>().refresh(),
            );
          }

          if (state is CategoryDetailsLoaded) {
            return RefreshIndicator(
              onRefresh: () => context.read<CategoryDetailsCubit>().refresh(),
              child: CustomScrollView(
                slivers: [
                  // Search bar
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: SellioSearchBar(
                        hintText: context.local.search_in(categoryName),
                        onFilterIconClicked: () {
                          // TODO: Implement filter behavior if needed
                        },
                      ),
                    ),
                  ),

                  // Tabs
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _StickyTabBarDelegate(
                      child: Container(
                        color: colors.surfaceLow,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: List.generate(
                              1 + state.subcategories.length,
                              (index) {
                                final isSelected =
                                    index == state.selectedTabIndex;
                                final colors = SellioTheme.of(context).colors;

                                String label;
                                label = index == 0
                                    ? context.local.all
                                    : state.subcategories[index - 1].name;

                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: ChoiceChip(
                                    label: Text(label),
                                    selected: isSelected,
                                    showCheckmark: false,
                                    onSelected: (_) {
                                      context
                                          .read<CategoryDetailsCubit>()
                                          .selectTab(index);
                                    },
                                    selectedColor: colors.primary,
                                    backgroundColor: Colors.white,
                                    labelStyle: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : colors.title,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: BorderSide(
                                        color: isSelected
                                            ? colors.primary
                                            : colors.stroke,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Products grid
                  if (state.isProductsLoading)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    )
                  else if (state.products.isEmpty)
                    const SliverToBoxAdapter(child: _EmptyView())
                  else
                    _ProductsGrid(products: state.products),

                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// Sticky tab bar delegate
class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyTabBarDelegate({required this.child});

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      child;

  @override
  double get maxExtent => 64;

  @override
  double get minExtent => 64;

  @override
  bool shouldRebuild(covariant _StickyTabBarDelegate oldDelegate) => true;
}

// Products Grid
class _ProductsGrid extends StatelessWidget {
  final List<Product> products;

  const _ProductsGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      sliver: SliverLayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.crossAxisExtent;
          const cardWidth = 170.0;
          final crossAxisCount = (screenWidth / cardWidth).floor().clamp(1, 6);

          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 8,
              mainAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final product = products[index];
                return CustomerProductCard(
                  productId: product.id,
                  imageUrl:
                      product.images.isNotEmpty ? product.images.first : '',
                  title: product.title,
                  formattedPrice: product.minPrice.toString(),
                  rawPrice: double.tryParse(product.minPrice
                          .toString()
                          .replaceAll(RegExp(r'[^\d.]'), '')) ??
                      0.0,
                  currency: product.currency ?? 'EGP',
                  isFavorite: product.isFavorite,
                  onTap: () => navigateToProductDetails(context, product.id),
                  onFavoriteToggle: () {},
                );
              },
              childCount: products.length,
            ),
          );
        },
      ),
    );
  }
}

// Loading View
class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

// Empty View
class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    final colors = SellioTheme.of(context).colors;
    return Padding(
      padding: const EdgeInsets.all(48),
      child: Column(
        children: [
          Icon(Icons.inbox_outlined, size: 64, color: colors.title),
          const SizedBox(height: 16),
          Text(
            'No products found',
            style: context.theme.typography.textTheme.titleSmall.copyWith(
              color: colors.title,
            ),
          ),
        ],
      ),
    );
  }
}

// Error View
class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
          const SizedBox(height: 16),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
