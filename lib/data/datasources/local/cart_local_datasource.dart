import '../../models/cart_item_model.dart';
import '../../models/cart_model.dart';

abstract class CartLocalDataSource {
  Future<CartModel?> getCachedCart();

  Future<void> cacheCart(CartModel cart);

  Future<void> clearCartCache();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  CartModel? _cachedCart;

  CartLocalDataSourceImpl();

  @override
  Future<CartModel?> getCachedCart() async {
    // Return empty cart if not cached, or fake cart with sample items
    if (_cachedCart == null) {
      return _getFakeCart();
    }
    return _cachedCart;
  }

  @override
  Future<void> cacheCart(CartModel cart) async {
    _cachedCart = cart;
  }

  @override
  Future<void> clearCartCache() async {
    _cachedCart = null;
  }

  // Fake cart data
  CartModel _getFakeCart() {
    return CartModel(
      id: 'cart_001',
      userId: 'user_001',
      items: [
        CartItemModel(
          id: 'item_001',
          productId: 'prod_001',
          productName: 'Smartphone Pro Max',
          productImage: 'https://via.placeholder.com/400x400',
          price: 999.99,
          quantity: 1,
          currency: 'USD',
        ),
        CartItemModel(
          id: 'item_002',
          productId: 'prod_003',
          productName: 'Designer T-Shirt',
          productImage: 'https://via.placeholder.com/400x400',
          price: 29.99,
          quantity: 2,
          currency: 'USD',
        ),
      ],
      totalPrice: 1059.97,
    );
  }
}
