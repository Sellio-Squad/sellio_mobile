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

  /// Update item quantity
  Future<Cart> updateQuantity(String productId, int quantity);

  /// Clear cart
  Future<void> clearCart();

  /// Get cart item count (total items)
  Future<int> getCartItemCount();

  /// Get cart counts per product (productId -> quantity)
  Future<Map<String, int>> getCartCounts();
}