import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:sellio_mobile/domain/entities/product.dart';
import 'package:sellio_mobile/domain/repositories/product_repository.dart';
import '../../../../core/error/result.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
   final ProductRepository _productRepository;
  SearchCubit(this._productRepository) : super(const SearchInitial());

  final List<String> _recentSearches = [
    "Cake",
    "shoes",
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
    final result = await _productRepository.searchProducts(query: text);


    if (result.isSuccess) {
      final products = (result as Success<List<Product>>).data;
      if (products.isNotEmpty) {
        emit(SearchSuccess(products));
      }else {
        emit(SearchEmpty());
      }


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
