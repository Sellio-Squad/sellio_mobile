import '../core/result.dart';
import '../entities/cart.dart';

abstract class CartRepository {
  /// Get current cart
  Future<Result<Cart>> getCart();

  /// Add item to cart
  Future<Result<Cart>> addToCart({
    required String productId,
    required int quantity,
  });

  /// Remove item from cart
  Future<Result<Cart>> removeFromCart(String cartItemId);

  /// Update item quantity
  Future<Result<Cart>> updateQuantity(String productId, int quantity);

  /// Clear cart
  Future<Result<void>> clearCart();

  /// Get cart item count (total items)
  Future<Result<int>> getCartItemCount();

  /// Get cart counts per product (productId -> quantity)
  Future<Result<Map<String, int>>> getCartCounts();
}