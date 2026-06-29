import 'package:core/error/failure.dart';
import 'package:core/error/result.dart';
import '../../domain/entities/cart.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasource/local/cart_local_datasource.dart';
import '../mappers/cart_mapper.dart';
import '../models/cart_item_model.dart';
import '../models/cart_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource _localDataSource;

  CartRepositoryImpl({
    required CartLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  @override
  Future<Result<Cart>> getCart() async {
    try {
      final cartModel = await _localDataSource.getCart();
      final cart = CartMapper.toEntity(cartModel);
      return Success(cart);
    } catch (e) {
      return ResultFailure(
        CacheFailure(message: 'Failed to get cart: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<Cart>> addToCart({
    required String productId,
    required String productName,
    required String productImage,
    required double price,
    required String currency,
    required int quantity,
  }) async {
    try {
      final currentCart = await _localDataSource.getCart();
      final items = List<CartItemModel>.from(currentCart.items);

      final existingIndex = items.indexWhere(
        (item) => item.productId == productId,
      );

      if (existingIndex != -1) {
        // Update existing item
        final existingItem = items[existingIndex];
        items[existingIndex] = existingItem.copyWith(
          quantity: existingItem.quantity + quantity,
        );
      } else {
        // Add new item
        items.add(
          CartItemModel(
            productId: productId,
            productName: productName,
            productImage: productImage,
            price: price,
            quantity: quantity,
            currency: currency,
          ),
        );
      }

      final updatedCart = CartModel(items: items);
      await _localDataSource.saveCart(updatedCart);

      return Success(CartMapper.toEntity(updatedCart));
    } catch (e) {
      return ResultFailure(
        CacheFailure(message: 'Failed to add to cart: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<Cart>> removeFromCart(String productId) async {
    try {
      final currentCart = await _localDataSource.getCart();
      final items = currentCart.items
          .where((item) => item.productId != productId)
          .toList();

      final updatedCart = CartModel(items: items);
      await _localDataSource.saveCart(updatedCart);

      return Success(CartMapper.toEntity(updatedCart));
    } catch (e) {
      return ResultFailure(
        CacheFailure(message: 'Failed to remove from cart: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<Cart>> updateQuantity(String productId, int quantity) async {
    try {
      if (quantity < 1) {
        return ResultFailure(
          ValidationFailure(message: 'Quantity must be at least 1'),
        );
      }

      final currentCart = await _localDataSource.getCart();
      final items = currentCart.items.map((item) {
        if (item.productId == productId) {
          return item.copyWith(quantity: quantity);
        }
        return item;
      }).toList();

      final updatedCart = CartModel(items: items);
      await _localDataSource.saveCart(updatedCart);

      return Success(CartMapper.toEntity(updatedCart));
    } catch (e) {
      return ResultFailure(
        CacheFailure(message: 'Failed to update quantity: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Result<void>> clearCart() async {
    try {
      await _localDataSource.clearCart();
      return const Success(null);
    } catch (e) {
      return ResultFailure(
        CacheFailure(message: 'Failed to clear cart: ${e.toString()}'),
      );
    }
  }
}
