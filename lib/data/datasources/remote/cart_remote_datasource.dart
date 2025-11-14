import 'package:dio/dio.dart';

import '../../models/cart_model.dart';
import 'api_service/api_service.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> getCart();

  Future<CartModel> addToCart({
    required String productId,
    required int quantity,
  });

  Future<CartModel> removeFromCart(String cartItemId);

  Future<CartModel> updateCartItem({
    required String cartItemId,
    required int quantity,
  });

  /// NEW → Update quantity using productId instead of cartItemId
  Future<CartModel> updateQuantityByProductId({
    required String productId,
    required int quantity,
  });

  Future<void> clearCart();
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final ApiService _apiService;

  CartRemoteDataSourceImpl(this._apiService);

  @override
  Future<CartModel> getCart() async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>('/cart');

      return CartModel.fromJson(response.data!['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<CartModel> addToCart({
    required String productId,
    required int quantity,
  }) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/cart/items',
        data: {
          'productId': productId,
          'quantity': quantity,
        },
      );

      return CartModel.fromJson(response.data!['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<CartModel> removeFromCart(String cartItemId) async {
    try {
      final response =
      await _apiService.delete<Map<String, dynamic>>('/cart/items/$cartItemId');

      return CartModel.fromJson(response.data!['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<CartModel> updateCartItem({
    required String cartItemId,
    required int quantity,
  }) async {
    try {
      final response = await _apiService.patch<Map<String, dynamic>>(
        '/cart/items/$cartItemId',
        data: {
          'quantity': quantity,
        },
      );

      return CartModel.fromJson(response.data!['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// ================================
  /// NEW: Update quantity using productId
  /// ================================
  @override
  Future<CartModel> updateQuantityByProductId({
    required String productId,
    required int quantity,
  }) async {
    try {
      // Step 1: get cart to find cartItemId
      final cart = await getCart();

      final item = cart.items.firstWhere(
            (e) => e.productId == productId,
        orElse: () => throw Exception("Product not in cart"),
      );

      // Step 2: update using cartItemId
      return await updateCartItem(
        cartItemId: item.id,
        quantity: quantity,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      await _apiService.delete('/cart');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final message = e.response!.data['message']?.toString() ?? "Error";

      switch (statusCode) {
        case 400:
          return Exception('Bad request: $message');
        case 401:
          return Exception('Unauthorized: $message');
        case 404:
          return Exception('Not found: $message');
        case 500:
          return Exception('Server error: $message');
        default:
          return Exception('Error: $message');
      }
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return Exception("Connection timeout");
    }

    if (e.type == DioExceptionType.connectionError) {
      return Exception("No internet connection");
    }

    return Exception("Unknown error occurred");
  }
}
