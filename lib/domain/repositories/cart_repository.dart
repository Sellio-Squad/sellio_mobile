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
}