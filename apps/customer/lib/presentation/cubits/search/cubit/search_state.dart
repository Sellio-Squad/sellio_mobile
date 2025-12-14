part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchRecent extends SearchState {
  final List<String> recentSearches;

  const SearchRecent(this.recentSearches);

  @override
  List<Object?> get props => [recentSearches];
}


class SearchSuccess extends SearchState {
  final List<Product> products;

  const SearchSuccess(this.products);

  @override
  List<Object?> get props => [products];
}

class SearchEmpty extends SearchState {
  const SearchEmpty();
}
