import '../entities/cart.dart';

abstract class CartRepository {
  /// Get current cart
  Future<Cart> getCart();

  /// Add item to cart
  Future<Cart> addToCart({
    required String productId,
    required int quantity,
  });

  /// Remove item from cart
  Future<Cart> removeFromCart(String cartItemId);
}