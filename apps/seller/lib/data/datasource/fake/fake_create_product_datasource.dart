import '../../../../domain/entities/category.dart';
import '../../../../domain/entities/subcategory.dart';

abstract class FakeCreateProductDataSource {
  Future<List<Category>> getCategories();

  Future<List<Subcategory>> getSubcategories(String categoryId);

  Future<List<Map<String, String>>> getColors();

  Future<List<Map<String, String>>> getSizes();

  Future<List<Map<String, String>>> getDiscounts();
}

class FakeCreateProductDataSourceImpl implements FakeCreateProductDataSource {
  @override
  Future<List<Category>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return const [
      Category(id: 'cat-clothes', name: 'Clothes'),
      Category(id: 'cat-foods', name: 'Foods'),
      Category(id: 'cat-makeup', name: 'Makeup'),
      Category(id: 'cat-electronics', name: 'Electronics'),
    ];
  }

  @override
  Future<List<Subcategory>> getSubcategories(String categoryId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final allSubcategories = {
      'cat-clothes': [
        const Subcategory(id: 'sub-tshirts', name: 'T-Shirts'),
        const Subcategory(id: 'sub-jeans', name: 'Jeans'),
      ],
      'cat-foods': [
        const Subcategory(id: 'sub-snacks', name: 'Snacks'),
        const Subcategory(id: 'sub-drinks', name: 'Drinks'),
      ],
      'cat-makeup': [
        const Subcategory(id: 'sub-lipstick', name: 'Lipstick'),
        const Subcategory(id: 'sub-eyeliner', name: 'Eyeliner'),
      ],
      'cat-electronics': [
        const Subcategory(
            id: '33333333-d4d4-e5e5-f6f6-333333333333', name: 'Keyboards'),
        const Subcategory(id: 'sub-mice', name: 'Mice'),
      ],
    };

    return allSubcategories[categoryId] ?? [];
  }

  @override
  Future<List<Map<String, String>>> getColors() async {
    return [
      {'id': '3fa85f64-5717-4562-b3fc-2c963f66afa6', 'name': 'Red'},
      {'id': 'color-blue', 'name': 'Blue'},
      {'id': 'color-black', 'name': 'Black'},
    ];
  }

  @override
  Future<List<Map<String, String>>> getSizes() async {
    return [
      {'id': '3fa85f64-5717-4562-b3fc-2c963f66afa6', 'name': 'M'},
      {'id': 'size-s', 'name': 'S'},
      {'id': 'size-l', 'name': 'L'},
      {'id': 'size-xl', 'name': 'XL'},
    ];
  }

  @override
  Future<List<Map<String, String>>> getDiscounts() async {
    return [
      {'id': '3fa85f64-5717-4562-b3fc-2c963f66afa6', 'name': '10% Off'},
      {'id': 'disc-20', 'name': '20% Off'},
      {'id': 'disc-50', 'name': '50% Off'},
    ];
  }
}
