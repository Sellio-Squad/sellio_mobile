import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  @override
  Future<List<Category>> getCategories() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      Category(
        id: '0',
        name: 'All',
      ),
      Category(
        id: '1',
        name: 'Food',
      ),
      Category(
        id: '2',
        name: 'Drinks',

      ),
      Category(
        id: '3',
        name: 'Clothes',
      ),
      Category(
        id: '4',
        name: 'Electronics',
      ),
      Category(
        id: '5',
        name: 'Fashion',
      ),
      Category(
        id: '6',
        name: 'Home',
      ),
    ];
  }

  @override
  Future<Category> getCategoryById(String categoryId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final categories = await getCategories();
    return categories.firstWhere(
          (category) => category.id == categoryId,
      orElse: () => throw Exception('Category not found'),
    );
  }

  @override
  Future<List<Category>> getFeaturedCategories() async {
    await Future.delayed(const Duration(milliseconds: 400));

    final allCategories = await getCategories();
    return allCategories.take(5).toList();
  }
}