import 'package:authentication/authentication.dart';
import 'package:core/core.dart';

import '../../domain/entity/store_seller.dart';
import '../../domain/repository/store_repository.dart';
import '../datasource/remote/store_remote_datasource.dart';
import '../models/store/create_store_request.dart';

class StoreRepositoryImpl implements StoreRepository {
  final StoreRemoteDataSource _remoteDataSource;

  StoreRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<StoreSeller>> createStore(CreateStoreRequest request) async {
    return RepositoryCallHandler.call(() async {
      final response = await _remoteDataSource.createStore(request);

      return StoreSeller(
        id: response.id,
        name: response.title,
        description: request.description,
        profileImage: response.avatarUrl,
        coverImage: response.coverUrl,
        rating: 0.0,
        address: Address(
          city: request.city,
          country: request.country,
        ),
        contactInfoList: [],
        categories: [],
        isFavorite: false,
        isActive: true,
      );
    });
  }
}
