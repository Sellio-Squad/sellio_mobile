part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  final SearchType selectedType;
  final Map<String, dynamic>? filters;

  const SearchState({
    required this.selectedType,
    this.filters,
  });

  @override
  List<Object?> get props => [selectedType, filters];
}

class SearchInitial extends SearchState {
  const SearchInitial({
    required SearchType selectedType,
    Map<String, dynamic>? filters,
  }) : super(
          selectedType: selectedType,
          filters: filters,
        );
}

class SearchLoading extends SearchState {
  const SearchLoading({
    required SearchType selectedType,
    Map<String, dynamic>? filters,
  }) : super(
          selectedType: selectedType,
          filters: filters,
        );
}

class SearchRecent extends SearchState {
  final List<String> recentSearches;

  const SearchRecent({
    required this.recentSearches,
    required SearchType selectedType,
    Map<String, dynamic>? filters,
  }) : super(
          selectedType: selectedType,
          filters: filters,
        );

  @override
  List<Object?> get props => [recentSearches, selectedType, filters];
}

class SearchProductsSuccess extends SearchState {
  final List<Product> products;

  const SearchProductsSuccess({
    required this.products,
    required SearchType selectedType,
    Map<String, dynamic>? filters,
  }) : super(
          selectedType: selectedType,
          filters: filters,
        );

  @override
  List<Object?> get props => [products, selectedType, filters];
}

class SearchStoresSuccess extends SearchState {
  final List<Store> stores;

  const SearchStoresSuccess({
    required this.stores,
    required SearchType selectedType,
    Map<String, dynamic>? filters,
  }) : super(
          selectedType: selectedType,
          filters: filters,
        );

  @override
  List<Object?> get props => [stores, selectedType, filters];
}

class SearchEmpty extends SearchState {
  const SearchEmpty({
    required SearchType selectedType,
    Map<String, dynamic>? filters,
  }) : super(
          selectedType: selectedType,
          filters: filters,
        );
}

enum SearchType {
  products,
  stores,
}