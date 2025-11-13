import 'dart:convert';
import '../../core/storage/local_storage.dart';
import '../../models/cart_model.dart';

abstract class CartLocalDataSource {
  Future<CartModel?> getCachedCart();
  Future<void> cacheCart(CartModel cart);
  Future<void> clearCart();
  Future<Map<String, int>> getCartCounts();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  static const _cartKey = 'cached_cart';
  static const _cartCountsKey = 'cart_counts';

  final LocalStorage _localStorage;

  CartLocalDataSourceImpl(this._localStorage);

  @override
  Future<CartModel?> getCachedCart() async {
    try {
      final jsonString = _localStorage.getString(_cartKey);
      if (jsonString != null) {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        return CartModel.fromJson(json);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheCart(CartModel cart) async {
    final jsonString = jsonEncode(cart.toJson());
    await _localStorage.setString(_cartKey, jsonString);

    final counts = <String, int>{};
    for (final item in cart.items) {
      counts[item.productId] = item.quantity;
    }
    await _localStorage.setString(_cartCountsKey, jsonEncode(counts));
  }

  @override
  Future<void> clearCart() async {
    await _localStorage.remove(_cartKey);
    await _localStorage.remove(_cartCountsKey);
  }

  @override
  Future<Map<String, int>> getCartCounts() async {
    try {
      final jsonString = _localStorage.getString(_cartCountsKey);
      if (jsonString != null) {
        final Map<String, dynamic> json = jsonDecode(jsonString);
        return json.map((key, value) => MapEntry(key, value as int));
      }
      return {};
    } catch (e) {
      return {};
    }
  }
}