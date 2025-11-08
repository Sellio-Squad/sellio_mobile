import '../../domain/entities/cart.dart';
import '../../domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  // In-memory storage for demo purposes
  final Map<String, int> _cartItems = {};

  @override
  Future<Cart> getCart() async {
    await Future.delayed(const Duration(milliseconds: 300));
    // TODO: Convert map to Cart entity
    throw UnimplementedError('Convert to Cart entity');
  }

  @override
  Future<Cart> addToCart({
    required String productId,
    required int quantity,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _cartItems[productId] = (_cartItems[productId] ?? 0) + quantity;
    return getCart();
  }

  @override
  Future<Cart> removeFromCart(String cartItemId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _cartItems.remove(cartItemId);
    return getCart();
  }

  @override
  Future<Cart> updateQuantity(String productId, int quantity) async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (quantity <= 0) {
      _cartItems.remove(productId);
    } else {
      _cartItems[productId] = quantity;
    }
    return getCart();
  }

  @override
  Future<void> clearCart() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _cartItems.clear();
  }



  // Helper method for CartCubit
  @override
  Future<Map<String, int>> getCartCounts() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Map.from(_cartItems);
  }

  @override
  Future<int> getCartItemCount() {
    // TODO: implement getCartItemCount
    throw UnimplementedError();
  }
}