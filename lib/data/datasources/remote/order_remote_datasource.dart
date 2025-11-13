import '../../core/api/api_endpoints.dart';
import '../../core/api/api_client.dart';
import '../../models/base/paginated_response.dart';
import '../../models/order_model.dart';
import '../../../domain/entities/order.dart';

abstract class OrderRemoteDataSource {
  Future<OrderModel> createOrder({
    required String storeId,
    required List<OrderItemModel> items,
    required String addressId,
    String? note,
  });

  Future<PaginatedResponse<OrderModel>> getOrders({
    OrderStatus? status,
    int page = 0,
    int pageSize = 20,
  });

  Future<OrderModel> getOrderById(String orderId);

  Future<OrderModel> cancelOrder(String orderId);

  Future<PaginatedResponse<OrderModel>> getCompletedOrders({
    int page = 0,
    int pageSize = 20,
  });
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final ApiClient _httpClient;

  OrderRemoteDataSourceImpl(this._httpClient);

  @override
  Future<OrderModel> createOrder({
    required String storeId,
    required List<OrderItemModel> items,
    required String addressId,
    String? note,
  }) async {
    final response = await _httpClient.post(
      ApiEndpoints.orders,
      data: {
        'storeId': storeId,
        'items': items.map((item) => item.toJson()).toList(),
        'addressId': addressId,
        'note': note,
      },
    );

    return OrderModel.fromJson(response.data);
  }

  @override
  Future<PaginatedResponse<OrderModel>> getOrders({
    OrderStatus? status,
    int page = 0,
    int pageSize = 20,
  }) async {
    final response = await _httpClient.get(
      ApiEndpoints.orders,
      queryParameters: {
        if (status != null) 'status': _orderStatusToString(status),
        'page': page,
        'size': pageSize,
      },
    );

    return PaginatedResponse.fromJson(
      response.data,
          (json) => OrderModel.fromJson(json),
    );
  }

  @override
  Future<OrderModel> getOrderById(String orderId) async {
    final response = await _httpClient.get(ApiEndpoints.orderById(orderId));
    return OrderModel.fromJson(response.data);
  }

  @override
  Future<OrderModel> cancelOrder(String orderId) async {
    final response = await _httpClient.put(
      ApiEndpoints.orderCancel(orderId),
    );
    return OrderModel.fromJson(response.data);
  }

  @override
  Future<PaginatedResponse<OrderModel>> getCompletedOrders({
    int page = 0,
    int pageSize = 20,
  }) async {
    final response = await _httpClient.get(
      ApiEndpoints.ordersCompleted,
      queryParameters: {
        'page': page,
        'size': pageSize,
      },
    );

    return PaginatedResponse.fromJson(
      response.data,
          (json) => OrderModel.fromJson(json),
    );
  }

  String _orderStatusToString(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'PENDING';
      case OrderStatus.processing:
        return 'IN_PROGRESS';
      case OrderStatus.completed:
        return 'COMPLETED';
      case OrderStatus.cancelled:
        return 'CANCELLED';
    }
  }
}