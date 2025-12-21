import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:sellio_mobile/domain/entities/product.dart';
import 'package:sellio_mobile/domain/repositories/search_repository.dart';
import '../../../../core/error/result.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _searchRepository;

  SearchCubit(this._searchRepository) : super(const SearchInitial());

  Future<void> init() async {
    final recentSearches = await _searchRepository.getRecentSearches();

    if (recentSearches.isSuccess) {
      final recent = (recentSearches as Success<List<String>>).data;

      if (recent.isEmpty) {
        emit(const SearchInitial());
      } else {
        emit(SearchRecent(List.from(recent)));
      }
    }
  }

  Future<void> search(String text) async {
    if (text.isEmpty) {
      init();
      return;
    }
    final result = await _searchRepository.searchProducts(query: text);

    if (result.isSuccess) {
      final products = (result as Success<List<Product>>).data;
      if (products.isNotEmpty) {
        await _searchRepository.addToRecentSearch(text);
        emit(SearchSuccess(products));
      } else {
        emit(SearchEmpty());
      }
    }
  }

  void clearRecent() {
    _searchRepository.clearAllRecentSearches();
    emit(const SearchInitial());
  }

  void selectRecent(String text) {
    search(text);
  }
}
