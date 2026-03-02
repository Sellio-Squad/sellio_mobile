import 'package:equatable/equatable.dart';
import 'package:sellio_mobile/presentation/screens/home/sections/categories/model/Catgeory_model.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();
}

class HomeCategoriesInitial extends CategoriesState {
  const HomeCategoriesInitial();

  @override
  List<Object?> get props => [];
}

class HomeCategoriesLoading extends CategoriesState {
  const HomeCategoriesLoading();

  @override
  List<Object?> get props => [];
}

class HomeCategoriesLoaded extends CategoriesState {
  final List<HomeCategoryModel> categories;

  const HomeCategoriesLoaded({
    required this.categories,
  });

  HomeCategoriesLoaded copyWith({
    List<HomeCategoryModel>? categories,
  }) {
    return HomeCategoriesLoaded(
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [categories];
}

class HomeCategoriesError extends CategoriesState {
  final String message;

  const HomeCategoriesError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
