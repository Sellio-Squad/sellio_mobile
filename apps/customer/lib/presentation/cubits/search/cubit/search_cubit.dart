import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:sellio_mobile/domain/entities/product.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchInitial());

  final List<String> _recentSearches = [
    "Cake",
    "shoes",
  ];
  final List<Product> _products = [
    Product(
        id: "123",
        name: "T-Shirt",
        description: "This is T-Shirt",
        price: 2.5,
        currency: "currency",
        images: [],
        storeId: "123",
        categoryId: "123",
        isAvailable: true,
        stockQuantity: 123),
    Product(
        id: "456",
        name: "Shoes",
        description: "This is Shoes",
        price: 2.5,
        currency: "currency",
        images: [],
        storeId: "123",
        categoryId: "123",
        isAvailable: true,
        stockQuantity: 123),
  ];

  void init() {
    if (_recentSearches.isEmpty) {
      emit(const SearchInitial());
    } else {
      emit(SearchRecent(List.from(_recentSearches)));
    }
  }

  void search(String text) async {
    if (text.isEmpty) {
      init();
      return;
    }

    //mock logic
    final hasResults = _products.where((product) => product.name == text);

    if (hasResults.isNotEmpty) {
      emit(SearchSuccess(_products));
    } else {
      emit(SearchEmpty());
    }
  }

  void clearRecent() {
    _recentSearches.clear();
    emit(const SearchInitial());
  }

  void selectRecent(String text) {
    search(text);
  }
}
