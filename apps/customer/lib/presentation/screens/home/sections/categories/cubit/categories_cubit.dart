import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/error/result.dart';
import 'package:sellio_mobile/domain/entities/category.dart';
import 'package:sellio_mobile/domain/repositories/category_repository.dart';
import 'package:sellio_mobile/presentation/screens/home/sections/categories/category_mappers.dart';
import 'package:sellio_mobile/presentation/screens/home/sections/categories/cubit/categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoryRepository repository;

  CategoriesCubit(this.repository) : super(const HomeCategoriesInitial());

  Future<void> fetchCategories() async {
    emit(const HomeCategoriesLoading());

    final Result<List<Category>> result = await repository.getCategories();

    result.fold(
      onSuccess: (categories) {
        if (categories.isEmpty) {
          emit(const HomeCategoriesLoaded(categories: []));
        } else {
          emit(HomeCategoriesLoaded(
            categories: categories.toCategoryModel(),
          ));
        }
      },
      onFailure: (errorMessage) {
        emit(HomeCategoriesError(message: errorMessage.message));
      },
    );
  }

  Future<void> refreshCategories() async {
    await fetchCategories();
  }
}
