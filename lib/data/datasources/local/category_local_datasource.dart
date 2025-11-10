import '../../models/category_model.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getCachedCategories();

  Future<void> cacheCategories(List<CategoryModel> categories);

  Future<void> clearCategoriesCache();
}

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  List<CategoryModel> _cachedCategories = [];

  CategoryLocalDataSourceImpl() {
    // Initialize with fake categories
    _cachedCategories = _getFakeCategories();
  }

  @override
  Future<List<CategoryModel>> getCachedCategories() async {
    if (_cachedCategories.isEmpty) {
      _cachedCategories = _getFakeCategories();
    }
    return _cachedCategories;
  }

  @override
  Future<void> cacheCategories(List<CategoryModel> categories) async {
    _cachedCategories = categories;
  }

  @override
  Future<void> clearCategoriesCache() async {
    _cachedCategories = [];
  }

  // Fake categories data
  List<CategoryModel> _getFakeCategories() {
    return [
      CategoryModel(id: 'cat_001', name: 'Electronics'),
      CategoryModel(id: 'cat_002', name: 'Computers'),
      CategoryModel(id: 'cat_003', name: 'Clothing'),
      CategoryModel(id: 'cat_004', name: 'Accessories'),
      CategoryModel(id: 'cat_005', name: 'Furniture'),
      CategoryModel(id: 'cat_006', name: 'Garden'),
      CategoryModel(id: 'cat_007', name: 'Books'),
      CategoryModel(id: 'cat_008', name: 'Sports'),
      CategoryModel(id: 'cat_009', name: 'Toys'),
      CategoryModel(id: 'cat_010', name: 'Food & Beverages'),
    ];
  }
}
