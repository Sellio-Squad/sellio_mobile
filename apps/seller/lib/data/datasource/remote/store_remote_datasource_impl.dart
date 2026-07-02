import 'package:core/core.dart';

import '../../core/api/api_endpoints.dart';
import '../../models/store/create_store_request.dart';
import '../../models/store/store_creation_response.dart';
import 'store_remote_datasource.dart';

class StoreRemoteDataSourceImpl implements StoreRemoteDataSource {
  final ApiClient _apiClient;

  StoreRemoteDataSourceImpl(this._apiClient);

  @override
  Future<StoreCreationResponse> register({
    required String name,
    required String description,
    required String phoneNumber,
    required String city,
    required String government,
    required String country,
    required String avatarImageURL,
    required String coverImageURL,
  }) async {
    final request = CreateStoreRequest(
      title: name,
      description: description,
      phoneNumber: phoneNumber,
      city: city,
      government: government,
      country: country,
      avatarImageURL: avatarImageURL,
      coverImageURL: coverImageURL,
    );

    final response = await _apiClient.post(
      ApiEndpoints.createStore,
      data: request.toJson(),
    );

    return StoreCreationResponse.fromJson(response.data);
  }
}
