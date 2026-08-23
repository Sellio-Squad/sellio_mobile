import 'package:core/error/failure.dart';
import 'package:core/error/result.dart';

import '../../domain/entities/cart.dart';
import '../../domain/repository/cart_repository.dart';
import '../datasource/remote/CartRemoteDataSource.dart';
import '../mappers/cart_mapper.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _remoteDataSource;

  CartRepositoryImpl({
    required CartRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Result<Cart>> getCart() async {
    try {
      final cartModel = await _remoteDataSource.getCart();

      return Success(
        CartMapper.toEntity(cartModel),
      );
    } catch (e) {
      return ResultFailure(
        ServerFailure(
          message: 'Failed to get cart: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Result<Cart>> addToCart({
    required String productId,
    required int quantity,
  }) async {
    try {
      if (quantity < 1) {
        return ResultFailure(
          ValidationFailure(
            message: 'Quantity must be at least 1',
          ),
        );
      }

      final cartModel = await _remoteDataSource.addToCart(
        productId: productId,
        quantity: quantity,
      );

      return Success(
        CartMapper.toEntity(cartModel),
      );
    } catch (e) {
      return ResultFailure(
        ServerFailure(
          message: 'Failed to add item to cart: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Result<Cart>> updateQuantity({
    required String itemId,
    required int quantity,
  }) async {
    try {
      if (quantity < 1) {
        return ResultFailure(
          ValidationFailure(
            message: 'Quantity must be at least 1',
          ),
        );
      }

      final cartModel = await _remoteDataSource.updateQuantity(
        itemId: itemId,
        quantity: quantity,
      );

      return Success(
        CartMapper.toEntity(cartModel),
      );
    } catch (e) {
      return ResultFailure(
        ServerFailure(
          message: 'Failed to update cart item: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Result<Cart>> removeFromCart({
    required String itemId,
  }) async {
    try {
      final cartModel = await _remoteDataSource.removeFromCart(
        itemId: itemId,
      );

      return Success(
        CartMapper.toEntity(cartModel),
      );
    } catch (e) {
      return ResultFailure(
        ServerFailure(
          message: 'Failed to remove item from cart: ${e.toString()}',
        ),
      );
    }
  }
}