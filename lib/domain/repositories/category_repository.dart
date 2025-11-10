import '../core/result.dart';
import '../entities/category.dart';

abstract class CategoryRepository {
  /// Get all categories
  Future<Result<List<Category>>> getCategories();

  /// Get category by ID
  Future<Result<Category>> getCategoryById(String categoryId);
}