import 'package:equatable/equatable.dart';
import 'package:seller/domain/entities/product.dart';
import 'package:seller/domain/entities/product_filter.dart';

sealed class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object?> get props => [];
}

class ProductListInitial extends ProductListState {
  const ProductListInitial();
}

class ProductListLoading extends ProductListState {
  const ProductListLoading();
}

class ProductListLoaded extends ProductListState {
  final List<Product> products;
  final bool hasAnyProducts;
  final String searchQuery;
  final ProductSort sort;
  final ProductTypeFilter typeFilter;
  final bool isListLoading;

  const ProductListLoaded({
    required this.products,
    required this.hasAnyProducts,
    this.searchQuery = '',
    this.sort = ProductSort.priceHighest,
    this.typeFilter = ProductTypeFilter.all,
    this.isListLoading = false,
  });

  bool get isFiltered =>
      searchQuery.isNotEmpty || typeFilter != ProductTypeFilter.all;

  ProductListLoaded copyWith({
    List<Product>? products,
    bool? hasAnyProducts,
    String? searchQuery,
    ProductSort? sort,
    ProductTypeFilter? typeFilter,
    bool? isListLoading,
  }) {
    return ProductListLoaded(
      products: products ?? this.products,
      hasAnyProducts: hasAnyProducts ?? this.hasAnyProducts,
      searchQuery: searchQuery ?? this.searchQuery,
      sort: sort ?? this.sort,
      typeFilter: typeFilter ?? this.typeFilter,
      isListLoading: isListLoading ?? this.isListLoading,
    );
  }

  @override
  List<Object?> get props => [
        products,
        hasAnyProducts,
        searchQuery,
        sort,
        typeFilter,
        isListLoading,
      ];
}

class ProductListError extends ProductListState {
  final String message;

  const ProductListError({required this.message});

  @override
  List<Object?> get props => [message];
}
