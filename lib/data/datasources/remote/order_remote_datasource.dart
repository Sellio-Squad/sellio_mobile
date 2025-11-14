import 'package:dio/dio.dart';

import '../../../domain/entities/address.dart';
import '../../../domain/entities/order.dart';
import '../../models/order_model.dart';
import 'api_service/api_service.dart';

abstract class OrderRemoteDataSource {
  Future<OrderModel> createOrder({
    required String storeId,
    required List<OrderItem> items,
    required Address deliveryAddress,
    String? note,
  });

  Future<List<OrderModel>> getOrders({
    OrderStatus? status,
    int page = 1,
    int limit = 20,
  });

  Future<OrderModel> getOrderById(String orderId);

  Future<OrderModel> cancelOrder(String orderId);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final ApiService _apiService;

  OrderRemoteDataSourceImpl(this._apiService);

  @override
  Future<OrderModel> createOrder({
    required String storeId,
    required List<OrderItem> items,
    required Address deliveryAddress,
    String? note,
  }) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/orders',
        data: {
          'storeId': storeId,
          'items': items
              .map((item) => {
                    'productId': item.productId,
                    'quantity': item.quantity,
                    'price': item.price,
                  })
              .toList(),
          'deliveryAddress': {
            'country': deliveryAddress.country,
            'city': deliveryAddress.city
          },
          if (note != null) 'note': note,
        },
      );

      return OrderModel.fromJson(
          response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<List<OrderModel>> getOrders({
    OrderStatus? status,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/orders',
        queryParameters: {
          if (status != null) 'status': status.toString().split('.').last,
          'page': page,
          'limit': limit,
        },
      );

      final data = response.data!['data'] as List<dynamic>;
      return data
          .map((json) => OrderModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<OrderModel> getOrderById(String orderId) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/orders/$orderId',
      );

      return OrderModel.fromJson(
          response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  @override
  Future<OrderModel> cancelOrder(String orderId) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/orders/$orderId/cancel',
      );

      return OrderModel.fromJson(
          response.data!['data'] as Map<String, dynamic>);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final message =
          e.response!.data['message'] as String? ?? 'Unknown error occurred';

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
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return Exception('Connection timeout');
    } else if (e.type == DioExceptionType.connectionError) {
      return Exception('No internet connection');
    } else {
      return Exception('Unknown error occurred');
    }
  }
}
