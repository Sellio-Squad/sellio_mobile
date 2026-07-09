import '../../models/store/create_store_request.dart';
import '../../models/store/store_creation_response.dart';

abstract class StoreRemoteDataSource {
  Future<StoreCreationResponse> createStore(CreateStoreRequest request);
}
