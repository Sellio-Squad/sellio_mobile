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
        images: ['https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8dCUyMHNoaXJ0fGVufDB8fDB8fHww'],
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
        images: ['https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfsKcLtcDvagrqCxPXwH7LG9Nddg1K83l6tQ&s'],
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
    final hasResults = _products.where((product) => product.name.toLowerCase().contains(text.toLowerCase()),);
    if (hasResults.isNotEmpty) {
      emit(SearchSuccess(hasResults.toList()));
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
