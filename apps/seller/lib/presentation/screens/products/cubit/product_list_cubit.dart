import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller/domain/entities/product.dart';
import 'package:seller/domain/entities/product_filter.dart';
import 'package:seller/domain/repositories/product_repository.dart';
import 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  final ProductRepository _productRepository;

  List<Product> _allProducts = [];
  String _searchQuery = '';
  ProductSort _sort = ProductSort.priceHighest;
  ProductTypeFilter _typeFilter = ProductTypeFilter.all;

  ProductListCubit(this._productRepository) : super(const ProductListInitial());

  Future<void> loadProducts() async {
    emit(const ProductListLoading());
    try {
      final products = await _productRepository.getProducts();
      _allProducts = products;
      _emitFilteredProducts();
    } catch (e) {
      emit(ProductListError(message: e.toString()));
    }
  }

  Future<void> refreshProducts() async {
    final currentState = state;
    if (currentState is! ProductListLoaded) {
      return loadProducts();
    }

    emit(currentState.copyWith(isListLoading: true));
    try {
      final products = await _productRepository.getProducts();
      _allProducts = products;
      _emitFilteredProducts();
    } catch (e) {
      emit(ProductListError(message: e.toString()));
    }
  }

  void search(String query) {
    _searchQuery = query.trim();
    _emitFilteredProducts();
  }

  void applySort(ProductSort sort) {
    _sort = sort;
    _emitFilteredProducts();
  }

  void applyTypeFilter(ProductTypeFilter filter) {
    _typeFilter = filter;
    _emitFilteredProducts();
  }

  void _emitFilteredProducts() {
    final products = _applyFiltersAndSort();
    
    emit(ProductListLoaded(
      products: products,
      hasAnyProducts: _allProducts.isNotEmpty,
      searchQuery: _searchQuery,
      sort: _sort,
      typeFilter: _typeFilter,
      isListLoading: false,
    ));
  }

  List<Product> _applyFiltersAndSort() {
    var filtered = List<Product>.from(_allProducts);

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      filtered = filtered.where((product) {
        final matchesTitle = product.title.toLowerCase().contains(query);
        final matchesDescription =
            product.description.toLowerCase().contains(query);
        return matchesTitle || matchesDescription;
      }).toList();
    }

    if (_typeFilter != ProductTypeFilter.all) {
      final isUsed = _typeFilter == ProductTypeFilter.thrift;
      filtered = filtered.where((product) => product.isUsed == isUsed).toList();
    }

    filtered.sort((a, b) {
      switch (_sort) {
        case ProductSort.priceHighest:
          return b.minPrice.compareTo(a.minPrice);
        case ProductSort.priceLowest:
          return a.minPrice.compareTo(b.minPrice);
        case ProductSort.stockHighest:
          return b.stockQuantity.compareTo(a.stockQuantity);
        case ProductSort.stockLowest:
          return a.stockQuantity.compareTo(b.stockQuantity);
      }
    });

    return filtered;
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _productRepository.deleteProduct(id);
      _allProducts.removeWhere((p) => p.id == id);
      _emitFilteredProducts();
    } catch (e) {
      emit(ProductListError(message: e.toString()));
    }
  }
}
