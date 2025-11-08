import 'package:equatable/equatable.dart';

import 'categories_cubit.dart';

sealed class CategoriesState extends Equatable {
  const CategoriesState();
}

class CategoriesInitial extends CategoriesState {
  const CategoriesInitial();
  @override
  List<Object?> get props => [];
}

class CategoriesLoading extends CategoriesState {
  const CategoriesLoading();
  @override
  List<Object?> get props => [];
}

class CategoriesLoaded extends CategoriesState {
  final List<CategoryPresentation> categories;
  final int selectedIndex;

  const CategoriesLoaded({
    required this.categories,
    this.selectedIndex = 0,
  });

  CategoriesLoaded copyWith({
    List<CategoryPresentation>? categories,
    int? selectedIndex,
  }) {
    return CategoriesLoaded(
      categories: categories ?? this.categories,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [categories, selectedIndex];
}

class CategoriesError extends CategoriesState {
  final String message;
  const CategoriesError({required this.message});
  @override
  List<Object?> get props => [message];
}