import 'dart:convert';
import '../../core/storage/storage_keys.dart';
import '../../core/storage/storage_service.dart';
import '../../models/cart_model.dart';

abstract class CartLocalDataSource {
  Future<CartModel> getCart();
  Future<void> saveCart(CartModel cart);
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final StorageService _storageService;

  CartLocalDataSourceImpl(this._storageService);

  @override
  Future<CartModel> getCart() async {
    try {
      final cartJson = await _storageService.get<String>(StorageKeys.cart);

      if (cartJson == null || cartJson.isEmpty) {
        return const CartModel(items: []);
      }

      final Map<String, dynamic> cartMap = jsonDecode(cartJson);
      return CartModel.fromJson(cartMap);
    } catch (e) {
      // Return empty cart on error
      return const CartModel(items: []);
    }
  }

  @override
  Future<void> saveCart(CartModel cart) async {
    try {
      final cartJson = jsonEncode(cart.toJson());
      await _storageService.save(StorageKeys.cart, cartJson);
    } catch (e) {
      throw Exception('Failed to save cart: $e');
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      await _storageService.remove(StorageKeys.cart);
    } catch (e) {
      throw Exception('Failed to clear cart: $e');
    }
  }
}
