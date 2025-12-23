part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  final SearchType selectedType;

  const SearchState(this.selectedType);

  @override
  List<Object?> get props => [selectedType];
}

class SearchInitial extends SearchState {
  const SearchInitial({required SearchType selectedType})
      : super(selectedType);
}

class SearchLoading extends SearchState {
  const SearchLoading({required SearchType selectedType})
      : super(selectedType);
}


class SearchRecent extends SearchState {
  final List<String> recentSearches;

  const SearchRecent({
    required this.recentSearches,
    required SearchType selectedType,
  }) : super(selectedType);

  @override
  List<Object?> get props => [recentSearches, selectedType];
}


class SearchProductsSuccess extends SearchState {
  final List<Product> products;

  const SearchProductsSuccess({
    required this.products,
    required SearchType selectedType,
  }) : super(selectedType);

  @override
  List<Object?> get props => [products, selectedType];
}

class SearchStoresSuccess extends SearchState {
  final List<Store> stores;

  const SearchStoresSuccess({
    required this.stores,
    required SearchType selectedType,
  }) : super(selectedType);

  @override
  List<Object?> get props => [stores, selectedType];
}

class SearchEmpty extends SearchState {
  const SearchEmpty({required SearchType selectedType}) : super(selectedType);
}

enum SearchType {
  products,
  stores,
}