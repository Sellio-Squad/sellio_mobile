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
}
