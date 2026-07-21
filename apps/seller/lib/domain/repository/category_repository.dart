import 'package:core/core.dart';

import '../entity/category.dart';

abstract class CategoryRepository {
  Future<Result<List<Category>>> getCategories();
}
