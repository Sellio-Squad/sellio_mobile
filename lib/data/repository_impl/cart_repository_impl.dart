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
      final cartModel = await _remoteDataSource.getCart();
      await _localDataSource.cacheCart(cartModel);
      return Success(cartModel.toEntity());
    } catch (e) {
      try {
        final cached = await _localDataSource.getCachedCart();
        if (cached != null) {
          return Success(cached.toEntity());
        }
      } catch (_) {}

      return ResultFailure(_mapExceptionToFailure(e));
    }
  }
  @override
  Future<Result<Cart>> addToCart({
    required String productId,
    required int quantity,
  }) async {
    try {
      final cartModel = await _remoteDataSource.addToCart(
        productId: productId,
        quantity: quantity,
      );

      await _localDataSource.cacheCart(cartModel);

      return Success(cartModel.toEntity());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }
  @override
  Future<Result<Cart>> removeFromCart(String cartItemId) async {
    try {
      final cartModel = await _remoteDataSource.removeFromCart(cartItemId);

      await _localDataSource.cacheCart(cartModel);

      return Success(cartModel.toEntity());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }
  @override
  Future<Result<Cart>> updateQuantity(String productId, int quantity) async {
    try {
      final cartModel = await _remoteDataSource.updateQuantityByProductId(
        productId: productId,
        quantity: quantity,
      );
      return Success(cartModel.toEntity());
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }
  @override
  Future<Result<Map<String, int>>> getCartCounts() async {
    try {
      final cartModel = await _remoteDataSource.getCart();

      final counts = {
        for (final item in cartModel.items) item.productId: item.quantity,
      };

      return Success(counts);
    } catch (e) {
      return ResultFailure(_mapExceptionToFailure(e));
    }
  }
  Failure _mapExceptionToFailure(Object e) {
    final message = e.toString();

    if (message.contains('No internet') || message.contains('timeout')) {
      return const NetworkFailure();
    } else if (message.contains('Unauthorized')) {
      return const UnauthorizedFailure();
    } else if (message.contains('Not found')) {
      return const NotFoundFailure();
    } else {
      return ServerFailure(message: message);
    }
  }
}
