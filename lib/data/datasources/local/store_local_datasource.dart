import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/store.dart';
import '../../models/category_model.dart';
import '../../models/store_model.dart';
import 'database_service/database_service.dart';

abstract class StoreLocalDataSource {
  Future<List<StoreModel>> getCachedStores();

  Future<void> cacheStores(List<StoreModel> stores);

  Future<StoreModel?> getCachedStoreById(String storeId);

  Future<void> cacheStore(StoreModel store);

  Future<void> clearStoresCache();

  Future<List<String>> getFavoriteStoreIds();

  Future<void> addFavoriteStore(String storeId);

  Future<void> removeFavoriteStore(String storeId);

  Future<bool> isFavoriteStore(String storeId);
}

class StoreLocalDataSourceImpl implements StoreLocalDataSource {
  final DatabaseService _databaseService;

  StoreLocalDataSourceImpl(this._databaseService);

  @override
  Future<List<StoreModel>> getCachedStores() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> storeMaps = await db.query('stores');

    final List<StoreModel> stores = [];
    for (final storeMap in storeMaps) {
      final storeId = storeMap['id'] as String;
      final categories = await _getStoreCategories(storeId);
      final contactInfo = await _getStoreContactInfo(storeId);
      stores.add(StoreModel.fromDbMap(storeMap, categories, contactInfo));
    }

    return stores;
  }

  @override
  Future<void> cacheStores(List<StoreModel> stores) async {
    final db = await _databaseService.database;
    final batch = db.batch();

    for (final store in stores) {
      batch.insert(
        'stores',
        store.toDbMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Insert categories
      for (final category in store.categories) {
        batch.insert(
          'store_categories',
          {
            'storeId': store.id,
            'categoryId': category.id,
            'categoryName': category.name,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      // Insert contact info
      batch.insert(
        'store_contacts',
        (store.contactInfo as ContactInfoModel).toDbMap(store.id),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<StoreModel?> getCachedStoreById(String storeId) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'stores',
      where: 'id = ?',
      whereArgs: [storeId],
    );

    if (maps.isEmpty) return null;

    final categories = await _getStoreCategories(storeId);
    final contactInfo = await _getStoreContactInfo(storeId);
    return StoreModel.fromDbMap(maps.first, categories, contactInfo);
  }

  @override
  Future<void> cacheStore(StoreModel store) async {
    final db = await _databaseService.database;
    await db.insert(
      'stores',
      store.toDbMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Delete old categories
    await db.delete(
      'store_categories',
      where: 'storeId = ?',
      whereArgs: [store.id],
    );

    // Insert new categories
    for (final category in store.categories) {
      await db.insert(
        'store_categories',
        {
          'storeId': store.id,
          'categoryId': category.id,
          'categoryName': category.name,
        },
      );
    }

    // Delete old contact info
    await db.delete(
      'store_contacts',
      where: 'storeId = ?',
      whereArgs: [store.id],
    );

    // Insert new contact info
    await db.insert(
      'store_contacts',
      (store.contactInfo as ContactInfoModel).toDbMap(store.id),
    );
  }

  @override
  Future<void> clearStoresCache() async {
    final db = await _databaseService.database;
    await db.delete('stores');
    await db.delete('store_categories');
    await db.delete('store_contacts');
  }

  @override
  Future<List<String>> getFavoriteStoreIds() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('favorite_stores');
    return maps.map((map) => map['storeId'] as String).toList();
  }

  @override
  Future<void> addFavoriteStore(String storeId) async {
    final db = await _databaseService.database;
    await db.insert(
      'favorite_stores',
      {'storeId': storeId},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removeFavoriteStore(String storeId) async {
    final db = await _databaseService.database;
    await db.delete(
      'favorite_stores',
      where: 'storeId = ?',
      whereArgs: [storeId],
    );
  }

  @override
  Future<bool> isFavoriteStore(String storeId) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'favorite_stores',
      where: 'storeId = ?',
      whereArgs: [storeId],
    );
    return maps.isNotEmpty;
  }

  Future<List<CategoryModel>> _getStoreCategories(String storeId) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'store_categories',
      where: 'storeId = ?',
      whereArgs: [storeId],
    );

    return maps
        .map((map) => CategoryModel(
              id: map['categoryId'] as String,
              name: map['categoryName'] as String,
            ))
        .toList();
  }

  Future<ContactInfoModel> _getStoreContactInfo(String storeId) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'store_contacts',
      where: 'storeId = ?',
      whereArgs: [storeId],
      limit: 1,
    );

    if (maps.isEmpty) {
      return ContactInfoModel(
        provider: '',
        type: ContactType.email,
      );
    }

    return ContactInfoModel.fromDbMap(maps.first);
  }
}
