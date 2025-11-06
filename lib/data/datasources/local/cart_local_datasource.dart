import 'package:sqflite/sqflite.dart';

import '../../models/cart_item_model.dart';
import '../../models/cart_model.dart';
import 'database_service/database_service.dart';

abstract class CartLocalDataSource {
  Future<CartModel?> getCachedCart();

  Future<void> cacheCart(CartModel cart);

  Future<void> clearCartCache();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final DatabaseService _databaseService;

  CartLocalDataSourceImpl(this._databaseService);

  @override
  Future<CartModel?> getCachedCart() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> cartMaps =
        await db.query('cart', limit: 1);

    if (cartMaps.isEmpty) return null;

    final cartMap = cartMaps.first;
    final cartId = cartMap['id'] as String;

    // Get cart items
    final List<Map<String, dynamic>> itemMaps = await db.query(
      'cart_items',
      where: 'cartId = ?',
      whereArgs: [cartId],
    );

    final items = itemMaps.map((map) => CartItemModel.fromDbMap(map)).toList();

    return CartModel.fromDbMap(cartMap, items);
  }

  @override
  Future<void> cacheCart(CartModel cart) async {
    final db = await _databaseService.database;

    // Insert cart
    await db.insert(
      'cart',
      cart.toDbMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Delete old cart items
    await db.delete(
      'cart_items',
      where: 'cartId = ?',
      whereArgs: [cart.id],
    );

    // Insert new cart items
    for (final item in cart.items) {
      await db.insert(
        'cart_items',
        (item as CartItemModel).toDbMap(cart.id),
      );
    }
  }

  @override
  Future<void> clearCartCache() async {
    final db = await _databaseService.database;
    await db.delete('cart');
    await db.delete('cart_items');
  }
}
