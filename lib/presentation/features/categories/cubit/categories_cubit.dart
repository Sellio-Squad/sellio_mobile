import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/design_system/constants/assets.dart';
import '../../../../../../domain/entities/category.dart';
import '../../../../../../domain/repositories/category_repository.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoryRepository _categoryRepository;

  CategoriesCubit(this._categoryRepository) : super(const CategoriesInitial());

  Future<void> loadCategories() async {
    emit(const CategoriesLoading());
    try {
      final categories = await _categoryRepository.getCategories();
      final categoriesWithIcons = categories.map((category) {
        final icon = _getCategoryIcon(category.name);
        return CategoryPresentation(category: category, icon: icon);
      }).toList();
      emit(CategoriesLoaded(categories: categoriesWithIcons));
    } catch (e) {
      emit(CategoriesError(message: e.toString()));
    }
  }

  void selectCategory(int index) {
    if (state is CategoriesLoaded) {
      emit((state as CategoriesLoaded).copyWith(selectedIndex: index));
    }
  }

  String _getCategoryIcon(String name) {
    const iconMap = {
      'All': Assets.allCategories,
      'Food': Assets.food,
      'Drinks': Assets.drinks,
      'Clothes': Assets.clothes,
    };
    return iconMap[name] ?? Assets.allCategories;
  }
}

// ========== HELPER CLASSES ==========
class CategoryPresentation extends Equatable {
  final Category category;
  final String icon;

  const CategoryPresentation({
    required this.category,
    required this.icon,
  });

  @override
  List<Object?> get props => [category, icon];
}