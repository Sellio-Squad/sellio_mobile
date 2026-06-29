import 'package:equatable/equatable.dart';
import '../../../../domain/entities/product.dart';
import '../../../../domain/entities/category.dart';

class ThriftProductsState extends Equatable {
  final bool isLoading;
  final bool isLoadingMore;

  final List<Product> items;
  final int currentPage;
  final int totalPages;

  final List<Category> categories;
  final String? selectedCategoryId;
  final String? errorMessage;

  const ThriftProductsState({
    this.isLoading = false,
    this.isLoadingMore = false,
    this.items = const [],
    this.currentPage = 1,
    this.totalPages = 1,
    this.categories = const [],
    this.selectedCategoryId,
    this.errorMessage,
  });

  ThriftProductsState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    List<Product>? items,
    int? currentPage,
    int? totalPages,
    List<Category>? categories,
    String? selectedCategoryId,
    bool clearSelectedCategory = false,
    String? errorMessage,
    Map<String, int>? productCounts,
    Map<String, bool>? favorites,
  }) {
    return ThriftProductsState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      categories: categories ?? this.categories,
      selectedCategoryId:
          clearSelectedCategory ? null : (selectedCategoryId ?? this.selectedCategoryId),
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isLoadingMore,
        items,
        currentPage,
        totalPages,
        categories,
        selectedCategoryId,
        errorMessage,
      ];
}
