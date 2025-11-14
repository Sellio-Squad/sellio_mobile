import '../../core/error/result.dart';
import '../../domain/entities/cart.dart';
import '../../domain/repositories/cart_repository.dart';
import '../core/storage/storage_service.dart';
import '../core/storage/storage_keys.dart';
import '../core/utils/repository_call_handler.dart';
import '../datasources/remote/cart_remote_datasource.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _remoteDataSource;
  final StorageService _storageService;

  CartRepositoryImpl({
    required CartRemoteDataSource remoteDataSource,
    required StorageService storageService,
  })  : _remoteDataSource = remoteDataSource,
        _storageService = storageService;

  Future<String?> _getUserId() => _storageService.get<String>(StorageKeys.userId);

  @override
  Future<Result<Cart>> getCart() async {
    return RepositoryCallHandler.callWithAuth<Cart>(
      _getUserId,
          (userId) async {
        final cartModel = await _remoteDataSource.getCart(userId);
        return cartModel.toEntity();
      },
    );
  }

  @override
  Future<Result<Cart>> addToCart({
    required String productId,
    required int quantity,
  }) async {
    return RepositoryCallHandler.callWithAuth<Cart>(
      _getUserId,
          (userId) async {
        final cartModel = await _remoteDataSource.addToCart(
          userId: userId,
          productId: productId,
          quantity: quantity,
        );
        return cartModel.toEntity();
      },
    );
  }

  @override
  Future<Result<Cart>> removeFromCart(String cartItemId) async {
    return RepositoryCallHandler.callWithAuth<Cart>(
      _getUserId,
          (userId) async {
        final cartModel = await _remoteDataSource.removeFromCart(
          userId: userId,
          cartItemId: cartItemId,
        );
        return cartModel.toEntity();
      },
    );
  }

  @override
  Future<Result<Cart>> updateQuantity(String productId, int quantity) async {
    return RepositoryCallHandler.callWithAuth<Cart>(
      _getUserId,
          (userId) async {
        final cartModel = await _remoteDataSource.updateQuantity(
          userId: userId,
          productId: productId,
          quantity: quantity,
        );
        return cartModel.toEntity();
      },
    );
  }
}