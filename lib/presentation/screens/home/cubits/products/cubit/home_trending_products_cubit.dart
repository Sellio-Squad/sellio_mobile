import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../domain/repositories/product_repository.dart';
import 'home_trending_products_state.dart';

class HomeTrendingProductsCubit extends Cubit<HomeTrendingProductsState> {
  final ProductRepository _productRepository;

  HomeTrendingProductsCubit(this._productRepository) : super(const HomeTrendingProductsInitial());

  Future<void> loadTrendingProducts({int limit = 10}) async {
    emit(const HomeTrendingProductsLoading());
    try {
      final products = await _productRepository.getTrendingProducts(limit: limit);
      emit(HomeTrendingProductsLoaded(products: products));
    } catch (e) {
      emit(HomeTrendingProductsError(message: e.toString()));
    }
  }

  Future<void> loadProductsByCategory(String categoryId, {int limit = 10}) async {
    emit(const HomeTrendingProductsLoading());
    try {
      final products = await _productRepository.getProductsByCategory(
        categoryId: categoryId,
        limit: limit,
      );
      emit(HomeTrendingProductsLoaded(products: products));
    } catch (e) {
      emit(HomeTrendingProductsError(message: e.toString()));
    }
  }

  Future<void> searchProducts(String query, {int limit = 20}) async {
    if (query.trim().isEmpty) {
      await loadTrendingProducts();
      return;
    }

    if (query.trim().length < 2) {
      emit(const HomeTrendingProductsError(message: 'Search query must be at least 2 characters'));
      return;
    }

    emit(HomeTrendingProductsSearching(query: query));
    try {
      final products = await _productRepository.searchProducts(
        query: query.trim(),
        limit: limit,
      );
      emit(HomeTrendingProductsLoaded(products: products, searchQuery: query));
    } catch (e) {
      emit(HomeTrendingProductsError(message: e.toString()));
    }
  }

  Future<void> refreshProducts() async {
    await loadTrendingProducts();
  }
}