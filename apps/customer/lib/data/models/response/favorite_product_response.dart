import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_product_response.freezed.dart';
part 'favorite_product_response.g.dart';

@freezed
class FavoriteProductResponse with _$FavoriteProductResponse {
  const factory FavoriteProductResponse({
    required String id,
    required String productId,
    required String userId,
    required DateTime createdAt,
  }) = _FavoriteProductResponse;

  factory FavoriteProductResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoriteProductResponseFromJson(json);
}

@freezed
class FavoriteProductsListResponse with _$FavoriteProductsListResponse {
  const factory FavoriteProductsListResponse({
    required List<FavoriteProductResponse> data,
    required int totalElements,
    required int page,
    required int pageSize,
    required int totalPages,
  }) = _FavoriteProductsListResponse;

  factory FavoriteProductsListResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoriteProductsListResponseFromJson(json);
}
