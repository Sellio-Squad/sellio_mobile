import '../../core/error/result.dart';
import '../entities/product.dart';
import '../entities/store.dart';

abstract class SearchRepository {
  Future<Result<List<Product>>> searchProducts({
    required String query,
    String? categoryId,
    double? minPrice,
    double? maxPrice,
    int page = 1,
    int limit = 20,
  });

  Future<Result<List<Store>>> searchStores({
    required String query,
    int page = 1,
    int limit = 20,
  });

  Future<Result<void>> addToRecentSearch(String query);

  Future<Result<List<String>>> getRecentSearches();

  Future<Result<void>> clearAllRecentSearches();
}
