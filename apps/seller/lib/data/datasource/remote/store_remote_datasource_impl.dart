import 'package:core/core.dart';

import '../../core/api/api_endpoints.dart';
import '../../models/store/create_store_request.dart';
import '../../models/store/store_creation_response.dart';
import 'store_remote_datasource.dart';

class StoreRemoteDataSourceImpl implements StoreRemoteDataSource {
  final ApiClient _apiClient;

  StoreRemoteDataSourceImpl(this._apiClient);

  @override
  Future<StoreCreationResponse> createStore(CreateStoreRequest request) async {
    final response = await _apiClient.post(
      ApiEndpoints.createStore,
      data: await request.toFormData(),
    );

    return StoreCreationResponse.fromJson(response.data);
  }

  @override
  Future<String> getStoreId() async {
    final response = await _apiClient.get(ApiEndpoints.storeOwner);
    final data = response.data;
    if (data is Map<String, dynamic>) {
      return (data['id'] ?? data['_id'])?.toString() ?? '';
    }
    return '';
  }
}
