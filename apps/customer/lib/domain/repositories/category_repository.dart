import 'package:core/error/result.dart';
import '../entities/category.dart';

abstract class CategoryRepository {
  Future<Result<List<Category>>> getCategories();

  Future<Result<Category>> getCategoryById(String categoryId);
}
