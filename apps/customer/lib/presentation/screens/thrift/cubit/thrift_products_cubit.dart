import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/common/paginated_data.dart';
import '../../../../domain/entities/product.dart';
import '../../../../domain/repositories/product_repository.dart';
import '../../../../domain/repositories/category_repository.dart';
import 'thrift_products_state.dart';

class ThriftProductsCubit extends Cubit<ThriftProductsState> {
  final ProductRepository _productRepository;
  final CategoryRepository _categoryRepository;

  ThriftProductsCubit(
      this._productRepository,
      this._categoryRepository,
      ) : super(const ThriftProductsState());

  Future<void> loadCategories() async {
    final result = await _categoryRepository.getCategories();

    result.fold(
      onFailure: (failure) {
        emit(state.copyWith(errorMessage: failure.message));
      },
      onSuccess: (data) {
        emit(state.copyWith(categories: data));
      },
    );
  }

  Future<void> loadThriftProducts({String? categoryId}) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _productRepository.getThriftProducts(
      page: 1,
      limit: 20,
      categoryId: categoryId,
    );

    result.fold(
      onFailure: (failure) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        ));
      },
      onSuccess: (PaginatedData<Product> data) {
        emit(state.copyWith(
          isLoading: false,
          items: data.items,
          currentPage: data.currentPage,
          totalPages: data.totalPages,
          selectedCategoryId: categoryId,
        ));
      },
    );
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore) return;
    if (state.currentPage >= state.totalPages) return;

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.currentPage + 1;

    final result = await _productRepository.getThriftProducts(
      categoryId: state.selectedCategoryId,
      page: nextPage,
      limit: 20,
    );

    result.fold(
      onFailure: (failure) {
        emit(state.copyWith(
          isLoadingMore: false,
          errorMessage: failure.message,
        ));
      },
      onSuccess: (PaginatedData<Product> data) {
        emit(state.copyWith(
          isLoadingMore: false,
          items: [...state.items, ...data.items],
          currentPage: data.currentPage,
          totalPages: data.totalPages,
        ));
      },
    );
  }

  Future<void> refresh() async {
    await loadThriftProducts(categoryId: state.selectedCategoryId);
  }

  Future<void> selectCategory(String? categoryId) async {
    emit(state.copyWith(selectedCategoryId: categoryId));
    await loadThriftProducts(categoryId: categoryId);
  }
}

