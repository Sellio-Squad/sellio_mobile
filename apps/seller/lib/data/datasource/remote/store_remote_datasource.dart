import '../../models/store/store_creation_response.dart';

abstract class StoreRemoteDataSource {
  Future<StoreCreationResponse> register({
    required String name,
    required String description,
    required String phoneNumber,
    required String city,
    required String government,
    required String country,
    required String avatarImageURL,
    required String coverImageURL,
  });
}
