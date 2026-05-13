import 'package:shared_preferences/shared_preferences.dart';

abstract class SearchLocalDatasource {
  Future<void> addToRecentSearch(String query);
  Future<List<String>> getRecentSearch();
  Future<void> clearAllRecentSearches();
}

class SearchLocalDataSourceImpl implements SearchLocalDatasource {
  static const _key = 'recent_search';

  @override
  Future<List<String>> getRecentSearch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  @override
  Future<void> addToRecentSearch(String query) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> recent = prefs.getStringList(_key) ?? [];
    recent.removeWhere((item) => item == query);
    recent.insert(0, query);
    await prefs.setStringList(_key, recent);
  }

  @override
  Future<void> clearAllRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
