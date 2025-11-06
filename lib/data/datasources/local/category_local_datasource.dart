import 'package:sqflite/sqflite.dart';

import '../../models/category_model.dart';
import 'database_service/database_service.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getCachedCategories();

  Future<void> cacheCategories(List<CategoryModel> categories);

  Future<void> clearCategoriesCache();
}

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  final DatabaseService _databaseService;

  CategoryLocalDataSourceImpl(this._databaseService);

  @override
  Future<List<CategoryModel>> getCachedCategories() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('categories');
    return maps.map((map) => CategoryModel.fromDbMap(map)).toList();
  }

  @override
  Future<void> cacheCategories(List<CategoryModel> categories) async {
    final db = await _databaseService.database;
    final batch = db.batch();

    for (final category in categories) {
      batch.insert(
        'categories',
        category.toDbMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<void> clearCategoriesCache() async {
    final db = await _databaseService.database;
    await db.delete('categories');
  }
}
