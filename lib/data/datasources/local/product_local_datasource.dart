import 'package:sqflite/sqflite.dart';

import '../../models/product_model.dart';
import 'database_service/database_service.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();

  Future<void> cacheProducts(List<ProductModel> products);

  Future<ProductModel?> getCachedProductById(String productId);

  Future<void> cacheProduct(ProductModel product);

  Future<void> clearProductsCache();

  Future<List<String>> getFavoriteProductIds();

  Future<void> addFavoriteProduct(String productId);

  Future<void> removeFavoriteProduct(String productId);

  Future<bool> isFavoriteProduct(String productId);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final DatabaseService _databaseService;

  ProductLocalDataSourceImpl(this._databaseService);

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> productMaps = await db.query('products');

    final List<ProductModel> products = [];
    for (final productMap in productMaps) {
      final images = await _getProductImages(productMap['id'] as String);
      products.add(ProductModel.fromDbMap(productMap, images));
    }

    return products;
  }

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    final db = await _databaseService.database;
    final batch = db.batch();

    for (final product in products) {
      batch.insert(
        'products',
        product.toDbMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Insert images
      for (final image in product.images) {
        batch.insert(
          'product_images',
          {
            'productId': product.id,
            'imageUrl': image,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<ProductModel?> getCachedProductById(String productId) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [productId],
    );

    if (maps.isEmpty) return null;

    final images = await _getProductImages(productId);
    return ProductModel.fromDbMap(maps.first, images);
  }

  @override
  Future<void> cacheProduct(ProductModel product) async {
    final db = await _databaseService.database;
    await db.insert(
      'products',
      product.toDbMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Delete old images
    await db.delete(
      'product_images',
      where: 'productId = ?',
      whereArgs: [product.id],
    );

    // Insert new images
    for (final image in product.images) {
      await db.insert(
        'product_images',
        {
          'productId': product.id,
          'imageUrl': image,
        },
      );
    }
  }

  @override
  Future<void> clearProductsCache() async {
    final db = await _databaseService.database;
    await db.delete('products');
    await db.delete('product_images');
  }

  @override
  Future<List<String>> getFavoriteProductIds() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('favorite_products');
    return maps.map((map) => map['productId'] as String).toList();
  }

  @override
  Future<void> addFavoriteProduct(String productId) async {
    final db = await _databaseService.database;
    await db.insert(
      'favorite_products',
      {'productId': productId},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removeFavoriteProduct(String productId) async {
    final db = await _databaseService.database;
    await db.delete(
      'favorite_products',
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  @override
  Future<bool> isFavoriteProduct(String productId) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'favorite_products',
      where: 'productId = ?',
      whereArgs: [productId],
    );
    return maps.isNotEmpty;
  }

  Future<List<String>> _getProductImages(String productId) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'product_images',
      where: 'productId = ?',
      whereArgs: [productId],
    );
    return maps.map((map) => map['imageUrl'] as String).toList();
  }
}
