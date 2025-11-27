import '../../core/api/api_endpoints.dart';
import '../../core/api/api_client.dart';
import '../../models/common/paginated_response.dart';
import '../../models/order_create_Item_model.dart';
import '../../models/order_model.dart';
import '../../models/response/order_confirmation_response.dart';

abstract class OrderRemoteDataSource {
  Future<OrderConfirmationResponse> createOrder({
    required List<OrderCreateItemModel> items,
  });

  Future<PaginatedResponse<OrderModel>> getOrders({
    String? status,
    int page = 0,
    int pageSize = 20,
  });

  Future<OrderModel> getOrderById(String orderId);

  Future<OrderModel> cancelOrder(String orderId);

}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final ApiClient _httpClient;

  OrderRemoteDataSourceImpl(this._httpClient);

  @override
  Future<OrderConfirmationResponse> createOrder({
    required List<OrderCreateItemModel> items,
  }) async {
    final response = await _httpClient.post(
      ApiEndpoints.orderConfirm,
      data: {
        'items': items
      },
    );

    return OrderConfirmationResponse.fromJson(response.data);
  }

  @override
  Future<PaginatedResponse<OrderModel>> getOrders({
    String? status,
    int page = 0,
    int pageSize = 20,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'size': pageSize,
      if (status != null) 'status': status,
    };

    final response = await _httpClient.get(
      ApiEndpoints.ordersHistory,
      queryParameters: queryParams,
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
    final response = await _httpClient.put(ApiEndpoints.orderCancel(orderId));
    return OrderModel.fromJson(response.data);
  }
}
