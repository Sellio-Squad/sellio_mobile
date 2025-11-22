import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_store_response.freezed.dart';
part 'favorite_store_response.g.dart';

@freezed
class FavoriteStoreResponse with _$FavoriteStoreResponse {
  const factory FavoriteStoreResponse({
    required String id,
    required String storeId,
    required String userId,
    required DateTime createdAt,
  }) = _FavoriteStoreResponse;

  factory FavoriteStoreResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoriteStoreResponseFromJson(json);
}

@freezed
class FavoriteStoresListResponse with _$FavoriteStoresListResponse {
  const factory FavoriteStoresListResponse({
    required List<FavoriteStoreResponse> data,
    required int totalElements,
    required int page,
    required int pageSize,
    required int totalPages,
  }) = _FavoriteStoresListResponse;

  factory FavoriteStoresListResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoriteStoresListResponseFromJson(json);
}
