import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../domain/repositories/product_repository.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductRepository _productRepository;

  ProductsCubit(this._productRepository) : super(const ProductsInitial());

  Future<void> loadTrendingProducts({int limit = 10}) async {
    emit(const ProductsLoading());
    try {
      final products = await _productRepository.getTrendingProducts(limit: limit);
      emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(ProductsError(message: e.toString()));
    }
  }

  Future<void> loadProductsByCategory(String categoryId, {int limit = 10}) async {
    emit(const ProductsLoading());
    try {
      final products = await _productRepository.getProductsByCategory(
        categoryId: categoryId,
        limit: limit,
      );
      emit(ProductsLoaded(products: products));
    } catch (e) {
      emit(ProductsError(message: e.toString()));
    }
  }

  Future<void> searchProducts(String query, {int limit = 20}) async {
    if (query.trim().isEmpty) {
      await loadTrendingProducts();
      return;
    }

    if (query.trim().length < 2) {
      emit(const ProductsError(message: 'Search query must be at least 2 characters'));
      return;
    }

    emit(ProductsSearching(query: query));
    try {
      final products = await _productRepository.searchProducts(
        query: query.trim(),
        limit: limit,
      );
      emit(ProductsLoaded(products: products, searchQuery: query));
    } catch (e) {
      emit(ProductsError(message: e.toString()));
    }
  }

  Future<void> refreshProducts() async {
    await loadTrendingProducts();
  }
}
