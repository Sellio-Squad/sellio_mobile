import 'package:core/core.dart';

import '../../core/api/api_endpoints.dart';
import '../../models/common/paginated_response.dart';
import '../../models/order_model.dart';
import '../../models/response/order_confirmation_response.dart';

abstract class OrderRemoteDataSource {
  Future<OrderConfirmationResponse> confirmOrder({
    String? note,
  });

  Future<PaginatedResponse<OrderModel>> getOrderHistory({
    String? status,
    int page = 0,
    int pageSize = 10,
    List<String> sort = const [
      'createdAt,DESC',
    ],
  });

  Future<void> cancelOrder({
    required String orderId,
  });
}

class OrderRemoteDataSourceImpl
    implements OrderRemoteDataSource {
  final ApiClient _httpClient;

  OrderRemoteDataSourceImpl(this._httpClient);

  @override
  Future<OrderConfirmationResponse> confirmOrder({
    String? note,
  }) async {
    final response = await _httpClient.post(
      ApiEndpoints.orderConfirm,
      data: {
        'note': note?.trim() ?? '',
      },
    );

    return OrderConfirmationResponse.fromJson(
      response.data,
    );
  }

  @override
  Future<PaginatedResponse<OrderModel>>
  getOrderHistory({
    String? status,
    int page = 0,
    int pageSize = 10,
    List<String> sort = const [
      'createdAt,DESC',
    ],
  }) async {
    final response = await _httpClient.get(
      ApiEndpoints.ordersHistory,
      queryParameters: {
        'page': page,
        'size': pageSize,
        'sort': sort,
        if (status != null && status.isNotEmpty)
          'status': status,
      },
    );

    return PaginatedResponse.fromJson(
      response.data,
          (json) => OrderModel.fromJson(
        json,
      ),
    );
  }

  @override
  Future<void> cancelOrder({
    required String orderId,
  }) async {
    await _httpClient.put(
      ApiEndpoints.orderCancel(orderId),
    );
  }
}