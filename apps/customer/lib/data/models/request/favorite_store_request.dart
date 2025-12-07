import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_store_request.freezed.dart';
part 'favorite_store_request.g.dart';

@freezed
class FavoriteStoreToggleRequest with _$FavoriteStoreToggleRequest {
  const factory FavoriteStoreToggleRequest({
    required String storeId,
  }) = _FavoriteStoreToggleRequest;

  factory FavoriteStoreToggleRequest.fromJson(Map<String, dynamic> json) =>
      _$FavoriteStoreToggleRequestFromJson(json);
}
