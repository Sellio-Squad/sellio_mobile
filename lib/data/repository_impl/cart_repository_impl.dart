import '../../domain/core/failure.dart';
import '../../domain/core/result.dart';
import '../../domain/entities/cart.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/local/cart_local_datasource.dart';
import '../datasources/remote/cart_remote_datasource.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _remoteDataSource;
  final CartLocalDataSource _localDataSource;

  CartRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Result<Cart>> getCart() async {
    try {
      final cart = await _remoteDataSource.getCart();

      // Cache cart
      await _localDataSource.cacheCart(cart);

      return Success(cart.toEntity());
    } catch (e) {
      // Try to get from cache
      try {
        final cachedCart = await _localDataSource.getCachedCart();
        if (cachedCart != null) {
          return Success(cachedCart.toEntity());
        }
      } catch (cacheError) {
        // Cache failed
      }

      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<Cart>> addToCart({
    required String productId,
    required int quantity,
  }) async {
    try {
      final cart = await _remoteDataSource.addToCart(
        productId: productId,
        quantity: quantity,
      );

      // Cache updated cart
      await _localDataSource.cacheCart(cart);

      return Success(cart.toEntity());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Result<Cart>> removeFromCart(String cartItemId) async {
    try {
      final cart = await _remoteDataSource.removeFromCart(cartItemId);

      // Cache updated cart
      await _localDataSource.cacheCart(cart);

      return Success(cart.toEntity());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }

  Failure _mapExceptionToFailure(Object e) {
    final message = e.toString();

    if (message.contains('No internet connection') ||
        message.contains('Connection timeout')) {
      return const NetworkFailure();
    } else if (message.contains('Unauthorized')) {
      return const UnauthorizedFailure();
    } else if (message.contains('Not found')) {
      return const NotFoundFailure();
    } else if (message.contains('Server error')) {
      return ServerFailure(message: message);
    } else {
      return ServerFailure(message: message);
    }
  }

  @override
  Future<Result<Cart>> updateQuantity(String productId, int quantity) {
    // TODO: implement updateQuantity
    throw UnimplementedError();
  }

  @override
  Future<Result<Map<String, int>>> getCartCounts() {
    // TODO: implement getCartCounts
    throw UnimplementedError();
  }
}
