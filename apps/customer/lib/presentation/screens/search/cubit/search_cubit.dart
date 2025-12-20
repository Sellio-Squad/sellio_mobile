import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:sellio_mobile/domain/entities/product.dart';
import 'package:sellio_mobile/domain/repositories/product_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/result.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final ProductRepository _productRepository;

  SearchCubit(this._productRepository) : super(const SearchInitial());

  late List<String> _recentSearches;

  Future<void> init() async {
    _recentSearches = await getRecentSearch();
    if (_recentSearches.isEmpty) {
      emit(const SearchInitial());
    } else {
      emit(SearchRecent(List.from(_recentSearches)));
    }
  }

  Future<void> search(String text) async {
    if (text.isEmpty) {
      init();
      return;
    }
    final result = await _productRepository.searchProducts(query: text);

    if (result.isSuccess) {
      final products = (result as Success<List<Product>>).data;
      if (products.isNotEmpty) {
        await saveRecentSearch(text);
        emit(SearchSuccess(products));
      } else {
        emit(SearchEmpty());
      }
    }
  }

  void clearRecent() {
    clearRecentSearch();
    emit(const SearchInitial());
  }

  void selectRecent(String text) {
    search(text);
  }

  Future<void> saveRecentSearch(String query) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> recent = prefs.getStringList('recent_search') ?? [];

    recent.insert(0, query);

    await prefs.setStringList('recent_search', recent);
  }

  Future<List<String>> getRecentSearch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('recent_search') ?? [];
  }
  Future<void> clearRecentSearch() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('recent_search');
  }
  }
