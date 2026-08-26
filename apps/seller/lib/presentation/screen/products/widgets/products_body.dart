import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:seller/core/localization/l10n/localization_service.dart';
import 'package:seller/domain/entity/product_filter.dart';
import '../cubit/product_list_cubit.dart';
import '../cubit/product_list_state.dart';
import 'products_filter_bottom_sheet.dart';
import 'products_list_section.dart';

class ProductsBody extends StatefulWidget {
  const ProductsBody({super.key});

  @override
  State<ProductsBody> createState() => _ProductsBodyState();
}

class _ProductsBodyState extends State<ProductsBody> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    context.read<ProductListCubit>().search(_searchController.text);
  }

  void _showFilterBottomSheet() {
    final cubit = context.read<ProductListCubit>();
    final state = cubit.state;
    final initialSort =
        state is ProductListLoaded ? state.sort : ProductSort.priceHighest;

    SellioBottomSheet.show(
      context: context,
      child: ProductsFilterBottomSheet(
        initialSort: initialSort,
        onApply: cubit.applySort,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: SellioSearchBar(
            controller: _searchController,
            hintText: context.local.search_products,
            isShowFilterIcon: true,
            onFilterIconClicked: _showFilterBottomSheet,
            onTextSubmitted: context.read<ProductListCubit>().search,
          ),
        ),
        const _ProductTypeChips(),
        const Gap(12),
        const Expanded(child: ProductsListSection()),
      ],
    );
  }
}

class _ProductTypeChips extends StatelessWidget {
  const _ProductTypeChips();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListCubit, ProductListState>(
      buildWhen: (previous, current) {
        if (previous is ProductListLoaded && current is ProductListLoaded) {
          return previous.typeFilter != current.typeFilter;
        }
        return previous.runtimeType != current.runtimeType;
      },
      builder: (context, state) {
        if (state is! ProductListLoaded) return const SizedBox.shrink();

        final filters = {
          ProductTypeFilter.all: context.local.all,
          ProductTypeFilter.regular: context.local.regular,
          ProductTypeFilter.thrift: context.local.thrift,
        };

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: filters.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SellioChip(
                  label: entry.value,
                  selected: state.typeFilter == entry.key,
                  onTap: () =>
                      context.read<ProductListCubit>().applyTypeFilter(entry.key),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
