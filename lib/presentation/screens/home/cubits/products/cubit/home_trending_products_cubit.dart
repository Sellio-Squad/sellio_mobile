import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../domain/repositories/product_repository.dart';
import 'home_trending_products_state.dart';

class HomeTrendingProductsCubit extends Cubit<HomeTrendingProductsState> {
  final ProductRepository _productRepository;

  HomeTrendingProductsCubit(this._productRepository)
      : super(const HomeTrendingProductsInitial());

  Future<void> loadTrendingProducts({int limit = 10}) async {
    emit(const HomeTrendingProductsLoading());

    final result = await _productRepository.getTrendingProducts(
      page: 1,
      limit: limit,
    );

    result.fold(
      onSuccess: (products) {
        emit(HomeTrendingProductsLoaded(products: products));
      },
      onFailure: (failure) {
        emit(HomeTrendingProductsError(message: failure.message));
      },
    );
  }

  Future<void> loadProductsByCategory(
      String categoryId, {
        int limit = 10,
      }) async {
    emit(const HomeTrendingProductsLoading());

    final result = await _productRepository.getProductsByCategory(
      categoryId: categoryId,
      page: 1,
      limit: limit,
    );

    result.fold(
      onSuccess: (products) {
        emit(HomeTrendingProductsLoaded(products: products));
      },
      onFailure: (failure) {
        emit(HomeTrendingProductsError(message: failure.message));
      },
    );
  }

  Future<void> searchProducts(String query, {int limit = 20}) async {
    if (query.trim().isEmpty) {
      await loadTrendingProducts();
      return;
    }

    if (query.trim().length < 2) {
      emit(const HomeTrendingProductsError(
        message: 'Search query must be at least 2 characters',
      ));
      return;
    }

    emit(HomeTrendingProductsSearching(query: query));

    final result = await _productRepository.searchProducts(
      query: query.trim(),
      page: 1,
      limit: limit,
    );

    result.fold(
      onSuccess: (products) {
        emit(HomeTrendingProductsLoaded(
          products: products,
          searchQuery: query,
        ));
      },
      onFailure: (failure) {
        emit(HomeTrendingProductsError(message: failure.message));
      },
    );
  }

  Future<void> refreshProducts() async {
    await loadTrendingProducts();
  }

  void reset() {
    emit(const HomeTrendingProductsInitial());
  }
}