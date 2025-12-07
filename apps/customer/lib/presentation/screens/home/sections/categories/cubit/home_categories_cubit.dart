import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:design_system/design_system.dart';
import '../../../../../../domain/entities/category.dart';
import '../../../../../../domain/repositories/category_repository.dart';
import 'home_categories_state.dart';

class HomeCategoriesCubit extends Cubit<HomeCategoriesState> {
  final CategoryRepository _categoryRepository;

  HomeCategoriesCubit(this._categoryRepository) : super(const HomeCategoriesInitial());

  Future<void> loadCategories() async {
    emit(const HomeCategoriesLoading());
    final result = await _categoryRepository.getCategories();
    
    result.fold(
      onFailure: (failure) {
        emit(HomeCategoriesError(message: failure.message));
      },
      onSuccess: (categories) {
        final categoriesWithIcons = categories.map((category) {
          final icon = _getCategoryIcon(category.name);
          return CategoryPresentation(category: category, icon: icon);
        }).toList();
        emit(HomeCategoriesLoaded(categories: categoriesWithIcons));
      },
    );
  }

  void selectCategory(int index) {
    if (state is HomeCategoriesLoaded) {
      emit((state as HomeCategoriesLoaded).copyWith(selectedIndex: index));
    }
  }

  String _getCategoryIcon(String name) {
    const iconMap = {
      'All': AppImages.allCategories,
      'Food': AppImages.food,
      'Drinks': AppImages.drinks,
      'Clothes': AppImages.clothes,
    };
    return iconMap[name] ?? AppImages.allCategories;
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
