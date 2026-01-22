import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:sellio_mobile/domain/entities/product.dart';
import 'package:sellio_mobile/domain/repositories/search_repository.dart';
import '../../../../core/error/result.dart';
import '../../../../domain/entities/store.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _searchRepository;

  SearchType _currentType = SearchType.products;
  String _lastQuery = '';


  SearchCubit(this._searchRepository)
      : super(const SearchInitial(selectedType: SearchType.products));

  Future<void> init() async {
    final result = await _searchRepository.getRecentSearches();
    if(result.data.isEmpty) return;

    if (result.isSuccess) {
      emit(SearchRecent(
        recentSearches: (result as Success<List<String>>).data,
        selectedType: _currentType,
      ));
    }
  }

  Future<void> search(String query) async {
    _searchRepository.addToRecentSearch(query);
    _lastQuery = query;

    if (query.isEmpty) {
      init();
      return;
    }

    switch (_currentType) {
      case SearchType.products:
        await _searchProducts(query);
        break;
      case SearchType.stores:
        await _searchStores(query);
        break;
    }
  }

  Future<void> _searchProducts(String query) async {
    emit(SearchLoading(selectedType: _currentType));
    final result = await _searchRepository.searchProducts(query: query);

    if (result.isSuccess) {
      final products = (result as Success<List<Product>>).data;

      emit(
        products.isEmpty
            ? SearchEmpty(selectedType: _currentType)
            : SearchProductsSuccess(
          products: products,
          selectedType: _currentType,
        ),
      );
    }
  }

  Future<void> _searchStores(String query) async {
    emit(SearchLoading(selectedType: _currentType));
    final result = await _searchRepository.searchStores(query: query);

    if (result.isSuccess) {
      final stores = (result as Success<List<Store>>).data;

      emit(
        stores.isEmpty
            ? SearchEmpty(selectedType: _currentType)
            : SearchStoresSuccess(
          stores: stores,
          selectedType: _currentType,
        ),
      );
    }
  }

  void selectTab(SearchType type) {

    if (_currentType == type) return;

    _currentType = type;
    if (_lastQuery.isNotEmpty) {
    search(_lastQuery);
    }
  }

  void clearRecent() {
    _searchRepository.clearAllRecentSearches();
    emit(SearchInitial(selectedType: _currentType));
  }

  void selectRecent(String text) {
    search(text);
  }
}
