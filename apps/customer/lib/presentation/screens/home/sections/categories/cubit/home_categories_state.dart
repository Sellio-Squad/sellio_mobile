import 'package:equatable/equatable.dart';
import 'home_categories_cubit.dart';

sealed class HomeCategoriesState extends Equatable {
  const HomeCategoriesState();
}

class HomeCategoriesInitial extends HomeCategoriesState {
  const HomeCategoriesInitial();
  @override
  List<Object?> get props => [];
}

class HomeCategoriesLoading extends HomeCategoriesState {
  const HomeCategoriesLoading();
  @override
  List<Object?> get props => [];
}

class HomeCategoriesLoaded extends HomeCategoriesState {
  final List<CategoryPresentation> categories;
  final int selectedIndex;

  const HomeCategoriesLoaded({
    required this.categories,
    this.selectedIndex = 0,
  });

  HomeCategoriesLoaded copyWith({
    List<CategoryPresentation>? categories,
    int? selectedIndex,
  }) {
    return HomeCategoriesLoaded(
      categories: categories ?? this.categories,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [categories, selectedIndex];
}

class HomeCategoriesError extends HomeCategoriesState {
  final String message;
  const HomeCategoriesError({required this.message});
  @override
  List<Object?> get props => [message];
}
