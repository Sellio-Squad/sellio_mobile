import 'package:equatable/equatable.dart';
import 'package:sellio_mobile/domain/entities/product.dart';
import 'package:sellio_mobile/domain/entities/subcategory.dart';

sealed class CategoryDetailsState extends Equatable {
  const CategoryDetailsState();
}

class CategoryDetailsInitial extends CategoryDetailsState {
  const CategoryDetailsInitial();

  @override
  List<Object?> get props => [];
}

class CategoryDetailsLoading extends CategoryDetailsState {
  const CategoryDetailsLoading();

  @override
  List<Object?> get props => [];
}

class CategoryDetailsLoaded extends CategoryDetailsState {
  final List<Subcategory> subcategories;
  final List<Product> products;
  final int selectedTabIndex;
  final bool isProductsLoading;

  const CategoryDetailsLoaded({
    required this.subcategories,
    required this.products,
    required this.selectedTabIndex,
    this.isProductsLoading = false,
  });

  CategoryDetailsLoaded copyWith({
    List<Subcategory>? subcategories,
    List<Product>? products,
    int? selectedTabIndex,
    bool? isProductsLoading,
  }) {
    return CategoryDetailsLoaded(
      subcategories: subcategories ?? this.subcategories,
      products: products ?? this.products,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      isProductsLoading: isProductsLoading ?? this.isProductsLoading,
    );
  }

  @override
  List<Object?> get props =>
      [subcategories, products, selectedTabIndex, isProductsLoading];
}

class CategoryDetailsError extends CategoryDetailsState {
  final String message;

  const CategoryDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}
