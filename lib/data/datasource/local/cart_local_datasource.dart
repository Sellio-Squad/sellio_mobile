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
      return CartModel.fromJsonString(cartJson);
    } catch (e) {
      return const CartModel(items: []);
    }
  }

  @override
  Future<void> saveCart(CartModel cart) async {
    await _storageService.save(StorageKeys.cart, cart.toJsonString());
  }

  @override
  Future<void> clearCart() async {
    await _storageService.remove(StorageKeys.cart);
  }
}