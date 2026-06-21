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
  Map<String, dynamic> _currentFilters = {};

  SearchCubit(this._searchRepository)
      : super(const SearchInitial(selectedType: SearchType.products));

  Future<void> init() async {
    final result = await _searchRepository.getRecentSearches();
    if (result.data.isEmpty) return;

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

    await _performSearch(query, _currentFilters);
  }

  Future<void> applyFilters(Map<String, dynamic> newFilters) async {
    _currentFilters = newFilters;
    if (_lastQuery.isNotEmpty) {
      await _performSearch(_lastQuery, _currentFilters);
    } else {
      emit(SearchAppliedFilters(selectedType: _currentType, filters: _currentFilters));
    }
  }

  Future<void> _performSearch(String query, Map<String, dynamic> filters) async {
    emit(SearchLoading(selectedType: _currentType, filters: filters));
    Result result;

    switch (_currentType) {
      case SearchType.products:
        result = await _searchRepository.searchProducts(query: query, filters: filters);
        if (result.isSuccess) {
          final products = (result as Success<List<Product>>).data;
          emit(
            products.isEmpty
                ? SearchEmpty(selectedType: _currentType, filters: filters)
                : SearchProductsSuccess(
                    products: products,
                    selectedType: _currentType,
                    filters: filters,
                  ),
          );
        }
        break;
      case SearchType.stores:
        result = await _searchRepository.searchStores(query: query, filters: filters);
        if (result.isSuccess) {
          final stores = (result as Success<List<Store>>).data;
          emit(
            stores.isEmpty
                ? SearchEmpty(selectedType: _currentType, filters: filters)
                : SearchStoresSuccess(
                    stores: stores,
                    selectedType: _currentType,
                    filters: filters,
                  ),
          );
        }
        break;
    }
  }

  void selectTab(SearchType type) {
    if (_currentType == type) return;

    _currentType = type;
    if (_lastQuery.isNotEmpty) {
      _performSearch(_lastQuery, _currentFilters);
    } else {
      emit(SearchInitial(selectedType: _currentType));
    }
  }

  void clearRecent() {
    _searchRepository.clearAllRecentSearches();
    emit(SearchInitial(selectedType: _currentType));
  }

  void selectRecent(String text) {
    _lastQuery = text;
    _performSearch(_lastQuery, _currentFilters);
  }
}