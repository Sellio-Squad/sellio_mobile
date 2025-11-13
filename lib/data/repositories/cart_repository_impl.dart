import '../../core/error/result.dart';
import '../../domain/entities/cart.dart';
import '../../domain/repositories/cart_repository.dart';
import '../core/utils/repository_call_handler.dart';
import '../core/storage/secure_storage.dart';
import '../datasources/local/cart_local_datasource.dart';
import '../datasources/remote/cart_remote_datasource.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _remoteDataSource;
  final CartLocalDataSource _localDataSource;
  final SecureStorage _secureStorage;

  CartRepositoryImpl({
    required CartRemoteDataSource remoteDataSource,
    required CartLocalDataSource localDataSource,
    required SecureStorage secureStorage,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _secureStorage = secureStorage;

  @override
  Future<Result<Cart>> getCart() async {
    return RepositoryCallHandler.callWithAuth<Cart>(
          () => _secureStorage.getUserId(),
          (userId) async {
        // Try to get from cache first
        final cachedCart = await _localDataSource.getCachedCart();
        if (cachedCart != null) {
          // Return cache and fetch in background
          _fetchAndCacheCart(userId);
          return cachedCart.toEntity();
        }

        try {
          // Fetch from server
          final cartModel = await _remoteDataSource.getCart(userId);
          await _localDataSource.cacheCart(cartModel);
          return cartModel.toEntity();
        } catch (e) {
          // Return cached data if server fails
          final fallbackCart = await _localDataSource.getCachedCart();
          if (fallbackCart != null) {
            return fallbackCart.toEntity();
          }
          rethrow;
        }
      },
    );
  }

  Future<void> _fetchAndCacheCart(String userId) async {
    try {
      final cartModel = await _remoteDataSource.getCart(userId);
      await _localDataSource.cacheCart(cartModel);
    } catch (e) {
      // Silent fail for background refresh
    }
  }

  @override
  Future<Result<Cart>> addToCart({
    required String productId,
    required int quantity,
  }) async {
    return RepositoryCallHandler.callWithAuth<Cart>(
          () => _secureStorage.getUserId(),
          (userId) async {
        final cartModel = await _remoteDataSource.addToCart(
          userId: userId,
          productId: productId,
          quantity: quantity,
        );

        await _localDataSource.cacheCart(cartModel);
        return cartModel.toEntity();
      },
    );
  }

  @override
  Future<Result<Cart>> removeFromCart(String cartItemId) async {
    return RepositoryCallHandler.callWithAuth<Cart>(
          () => _secureStorage.getUserId(),
          (userId) async {
        final cartModel = await _remoteDataSource.removeFromCart(
          userId: userId,
          cartItemId: cartItemId,
        );

        await _localDataSource.cacheCart(cartModel);
        return cartModel.toEntity();
      },
    );
  }

  @override
  Future<Result<Cart>> updateQuantity(String productId, int quantity) async {
    return RepositoryCallHandler.callWithAuth<Cart>(
          () => _secureStorage.getUserId(),
          (userId) async {
        final cartModel = await _remoteDataSource.updateQuantity(
          userId: userId,
          productId: productId,
          quantity: quantity,
        );

        await _localDataSource.cacheCart(cartModel);
        return cartModel.toEntity();
      },
    );
  }

  @override
  Future<Result<Map<String, int>>> getCartCounts() async {
    return RepositoryCallHandler.call<Map<String, int>>(
          () => _localDataSource.getCartCounts(),
    );
  }
}