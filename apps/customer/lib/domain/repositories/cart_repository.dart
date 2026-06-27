import 'package:core/error/result.dart';
import '../entities/cart.dart';

abstract class CartRepository {
  Future<Result<Cart>> getCart();

  Future<Result<Cart>> addToCart({
    required String productId,
    required String productName,
    required String productImage,
    required double price,
    required String currency,
    required int quantity,
  });

  Future<Result<Cart>> removeFromCart(String productId);

  Future<Result<Cart>> updateQuantity(String productId, int quantity);

  Future<Result<void>> clearCart();
}
