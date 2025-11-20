import '../../../core/error/result.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/repositories/category_repository.dart';
import '../../mock/mock_data_generator.dart';

class MockCategoryRepositoryImpl implements CategoryRepository {
  final List<Category> _categories = MockDataGenerator.generateCategories();

  Future<void> _simulateDelay() async {
    await Future.delayed(const Duration(milliseconds: 400));
  }

  @override
  Future<Result<List<Category>>> getCategories() async {
    await _simulateDelay();
    return Success(_categories);
  }

  @override
  Future<Result<Category>> getCategoryById(String categoryId) async {
    await _simulateDelay();

    final category = _categories.firstWhere(
          (c) => c.id == categoryId,
      orElse: () => MockDataGenerator.generateCategory(index: 0),
    );

    return Success(category);
  }
}