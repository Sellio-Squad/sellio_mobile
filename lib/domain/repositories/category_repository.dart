import '../entities/category.dart';

abstract class CategoryRepository {
  /// Get all categories
  Future<List<Category>> getCategories();

  /// Get category by ID
  Future<Category> getCategoryById(String categoryId);
}