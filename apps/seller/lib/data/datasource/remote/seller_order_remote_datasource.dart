import 'package:core/data/network/api_client.dart';

import '../../../domain/entities/seller_order.dart';
import '../../core/api/api_endpoints.dart';
import '../seller_order_datasource.dart';

class SellerOrderRemoteDataSource implements SellerOrderDataSource {
  final ApiClient _apiClient;

  SellerOrderRemoteDataSource({required ApiClient apiClient})
      : _apiClient = apiClient;

  @override
  Future<List<SellerOrder>> getOrders({
    int page = 1,
    int limit = 20,
  }) async {
    // TODO: Replace with real API integration when backend is ready.
    await _apiClient.get(
      ApiEndpoints.sellerOrders,
      queryParameters: {
        'page': page - 1,
        'size': limit,
      },
    );

    throw UnimplementedError(
      'Seller order remote datasource is not implemented yet.',
    );
  }
}
