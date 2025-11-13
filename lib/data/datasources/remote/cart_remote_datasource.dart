import '../../core/api/api_endpoints.dart';
import '../../core/api/http_client.dart';
import '../../models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> getCart(String userId);

  Future<CartModel> addToCart({
    required String userId,
    required String productId,
    required int quantity,
  });

  Future<CartModel> removeFromCart({
    required String userId,
    required String cartItemId,
  });

  Future<CartModel> updateQuantity({
    required String userId,
    required String productId,
    required int quantity,
  });

  Future<void> clearCart(String userId);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final HttpClient _httpClient;

  CartRemoteDataSourceImpl(this._httpClient);

  @override
  Future<CartModel> getCart(String userId) async {
    final response = await _httpClient.get(ApiEndpoints.cart(userId));
    return CartModel.fromJson(response.data);
  }

  @override
  Future<CartModel> addToCart({
    required String userId,
    required String productId,
    required int quantity,
  }) async {
    final response = await _httpClient.post(
      ApiEndpoints.cartAdd,
      data: {
        'userId': userId,
        'productId': productId,
        'quantity': quantity,
      },
    );

    return CartModel.fromJson(response.data);
  }

  @override
  Future<CartModel> removeFromCart({
    required String userId,
    required String cartItemId,
  }) async {
    final response = await _httpClient.delete(
      ApiEndpoints.cartRemove,
      data: {
        'userId': userId,
        'cartItemId': cartItemId,
      },
    );

    return CartModel.fromJson(response.data);
  }

  @override
  Future<CartModel> updateQuantity({
    required String userId,
    required String productId,
    required int quantity,
  }) async {
    final response = await _httpClient.put(
      ApiEndpoints.cartUpdate,
      data: {
        'userId': userId,
        'productId': productId,
        'quantity': quantity,
      },
    );

    return CartModel.fromJson(response.data);
  }

  @override
  Future<void> clearCart(String userId) async {
    await _httpClient.delete(ApiEndpoints.cartClear(userId));
  }
}