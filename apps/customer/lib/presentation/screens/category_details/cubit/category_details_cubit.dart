import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/domain/repositories/category_details_repository.dart';

import 'category_details_state.dart';

class CategoryDetailsCubit extends Cubit<CategoryDetailsState> {
  final CategoryDetailsRepository repository;
  final String categoryId;

  CategoryDetailsCubit({
    required this.repository,
    required this.categoryId,
  }) : super(const CategoryDetailsInitial());

  Future<void> initialize() async {
    emit(const CategoryDetailsLoading());

    final subcategoriesResult = await repository.getSubcategories(categoryId);
    final productsResult = await repository.getProductsByCategory(categoryId);

    subcategoriesResult.fold(
      onSuccess: (subcategories) {
        productsResult.fold(
          onSuccess: (products) {
            emit(CategoryDetailsLoaded(
              subcategories: subcategories,
              products: products,
              selectedTabIndex: 0,
            ));
          },
          onFailure: (error) {
            emit(CategoryDetailsError(message: error.message));
          },
        );
      },
      onFailure: (error) {
        emit(CategoryDetailsError(message: error.message));
      },
    );
  }

  Future<void> selectTab(int index) async {
    final currentState = state;
    if (currentState is! CategoryDetailsLoaded) return;

    emit(currentState.copyWith(
      selectedTabIndex: index,
      isProductsLoading: true,
    ));

    if (index == 0) {
      final result = await repository.getProductsByCategory(categoryId);
      result.fold(
        onSuccess: (products) => emit(currentState.copyWith(
          selectedTabIndex: index,
          products: products,
          isProductsLoading: false,
        )),
        onFailure: (error) =>
            emit(CategoryDetailsError(message: error.message)),
      );
    } else {
      final subcategoryIndex = index - 1;

      if (subcategoryIndex >= currentState.subcategories.length) return;

      final subcategory = currentState.subcategories[subcategoryIndex];
      final result = await repository.getProductsBySubcategory(subcategory.id);
      result.fold(
        onSuccess: (products) => emit(currentState.copyWith(
          selectedTabIndex: index,
          products: products,
          isProductsLoading: false,
        )),
        onFailure: (error) =>
            emit(CategoryDetailsError(message: error.message)),
      );
    }
  }

  Future<void> refresh() async => await initialize();
}
