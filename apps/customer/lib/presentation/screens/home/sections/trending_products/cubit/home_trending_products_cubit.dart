import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/domain/repositories/search_repository.dart';
import '../../../../../../domain/repositories/product_repository.dart';
import '../models/product_summary_ui_model.dart';
import 'home_trending_products_state.dart';

class HomeTrendingProductsCubit extends Cubit<HomeTrendingProductsState> {
  final ProductRepository _productRepository;
  final SearchRepository _searchRepository;

  HomeTrendingProductsCubit(this._productRepository, this._searchRepository)
      : super(const HomeTrendingProductsInitial());

  Future<void> loadTrendingProducts({int limit = 10}) async {
    emit(const HomeTrendingProductsLoading());

    final result = await _productRepository.getTrendingProducts(
      page: 1,
      limit: limit,
    );
    print('product list:$result');

    result.fold(
      onSuccess: (products) {
        final uiModels = products
            .map((product) => ProductSummaryUIModel.fromEntity(product))
            .toList();
        print('product list: onSuccess products: $uiModels');

        emit(HomeTrendingProductsLoaded(products: uiModels));
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
        final uiModels = products
            .map((product) => ProductSummaryUIModel.fromEntity(product))
            .toList();

        emit(HomeTrendingProductsLoaded(products: uiModels));
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

    final result = await _searchRepository.searchProducts(
      query: query.trim(),
      page: 1,
      limit: limit,
    );

    result.fold(
      onSuccess: (products) {
        final uiModels = products
            .map((product) => ProductSummaryUIModel.fromEntity(product))
            .toList();

        emit(HomeTrendingProductsLoaded(
          products: uiModels,
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
