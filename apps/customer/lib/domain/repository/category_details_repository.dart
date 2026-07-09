import 'package:core/error/result.dart';
import 'package:sellio_mobile/domain/entities/product.dart';
import 'package:sellio_mobile/domain/entities/subcategory.dart';

abstract class CategoryDetailsRepository {
  Future<Result<List<Subcategory>>> getSubcategories(String categoryId);

  Future<Result<List<Product>>> getProductsByCategory(
    String categoryId, {
    int page = 1,
    int limit = 20,
  });

  Future<Result<List<Product>>> getProductsBySubcategory(
    String subcategoryId, {
    int page = 1,
    int limit = 20,
  });
}
