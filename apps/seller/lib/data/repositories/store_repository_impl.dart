import 'dart:io';
import 'package:core/core.dart';
import 'package:authentication/authentication.dart';
import '../../domain/entity/store_seller.dart';
import '../../domain/repositories/store_repository.dart';
import '../datasource/remote/store_remote_datasource.dart';

class StoreRepositoryImpl implements StoreRepository {
  final StoreRemoteDataSource _remoteDataSource;

  StoreRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<StoreSeller>> createStore({
    required String name,
    required String description,
    required String city,
    required String country,
    required File profileImage,
    required File coverImage,
  }) async {
    return RepositoryCallHandler.call(() async {
      // TODO: Actually upload images and get URLs.
      // Using dummy URLs for now as we don't have an upload service implemented here.
      final response = await _remoteDataSource.register(
        name: name,
        description: description,
        phoneNumber: '01212121213',
        // Fake data for now
        city: city,
        government: city,
        // Fake data: using city as government
        country: country,
        avatarImageURL: 'http://example.com/avatar.jpg',
        // profileImage.path
        coverImageURL: 'http://example.com/cover.jpg', // coverImage.path
      );

      return StoreSeller(
        id: response.id,
        name: response.title,
        description: description,
        profileImage: response.avatarUrl,
        coverImage: response.coverUrl,
        isFavorite: false,
        isActive: true,
        rating: 0.0,
        address: Address(
          city: city,
          country: country,
        ),
        contactInfoList: [],
        categories: [],
      );
    });
  }
}
