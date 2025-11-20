import '../../core/error/result.dart';
import '../entities/cart.dart';

abstract class CartRepository {
  Future<Result<Cart>> getCart();

  Future<Result<Cart>> addToCart({
    required String productId,
    required int quantity,
  });

  Future<Result<Cart>> removeFromCart(String cartItemId);

  Future<Result<Cart>> updateQuantity(String productId, int quantity);
}