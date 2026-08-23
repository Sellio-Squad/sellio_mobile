import 'package:core/error/result.dart';

import '../entities/cart.dart';

abstract class CartRepository {
  Future<Result<Cart>> getCart();

  Future<Result<Cart>> addToCart({
    required String productId,
    required int quantity,
  });

  Future<Result<Cart>> updateQuantity({
    required String itemId,
    required int quantity,
  });

  Future<Result<Cart>> removeFromCart({
    required String itemId,
  });
}