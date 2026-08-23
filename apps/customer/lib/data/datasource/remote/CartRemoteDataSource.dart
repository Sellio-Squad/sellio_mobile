import 'package:core/core.dart';

import '../../core/api/api_endpoints.dart';
import '../../models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> getCart();

  Future<CartModel> addToCart({
    required String productId,
    required int quantity,
  });

  Future<CartModel> updateQuantity({
    required String itemId,
    required int quantity,
  });

  Future<CartModel> removeFromCart({
    required String itemId,
  });
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final ApiClient _httpClient;

  CartRemoteDataSourceImpl(this._httpClient);

  @override
  Future<CartModel> getCart() async {
    final response = await _httpClient.get(
      ApiEndpoints.cart,
    );

    return CartModel.fromJson(response.data);
  }

  @override
  Future<CartModel> addToCart({
    required String productId,
    required int quantity,
  }) async {
    final response = await _httpClient.post(
      ApiEndpoints.cartItems,
      data: {
        'productId': productId,
        'quantity': quantity,
      },
    );

    return CartModel.fromJson(response.data);
  }

  @override
  Future<CartModel> updateQuantity({
    required String itemId,
    required int quantity,
  }) async {
    final response = await _httpClient.put(
      ApiEndpoints.cartItemById(itemId),
      data: {
        'quantity': quantity,
      },
    );

    return CartModel.fromJson(response.data);
  }

  @override
  Future<CartModel> removeFromCart({
    required String itemId,
  }) async {
    final response = await _httpClient.delete(
      ApiEndpoints.cartItemById(itemId),
    );

    return CartModel.fromJson(response.data);
  }
}