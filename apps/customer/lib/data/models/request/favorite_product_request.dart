import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_product_request.freezed.dart';
part 'favorite_product_request.g.dart';

@freezed
class FavoriteProductToggleRequest with _$FavoriteProductToggleRequest {
  const factory FavoriteProductToggleRequest({
    required String productId,
  }) = _FavoriteProductToggleRequest;

  factory FavoriteProductToggleRequest.fromJson(Map<String, dynamic> json) =>
      _$FavoriteProductToggleRequestFromJson(json);
}
