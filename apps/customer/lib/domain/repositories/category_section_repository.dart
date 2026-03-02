import '../../core/error/result.dart';
import '../entities/category_section.dart';

abstract class CategorySectionRepository {
  Future<Result<List<CategorySection>>> getActiveSections();
}
