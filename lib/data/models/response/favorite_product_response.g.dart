// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FavoriteProductResponseImpl _$$FavoriteProductResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$FavoriteProductResponseImpl(
      id: json['id'] as String,
      productId: json['productId'] as String,
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$FavoriteProductResponseImplToJson(
        _$FavoriteProductResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$FavoriteProductsListResponseImpl _$$FavoriteProductsListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$FavoriteProductsListResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              FavoriteProductResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalElements: (json['totalElements'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
    );

Map<String, dynamic> _$$FavoriteProductsListResponseImplToJson(
        _$FavoriteProductsListResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'totalElements': instance.totalElements,
      'page': instance.page,
      'pageSize': instance.pageSize,
      'totalPages': instance.totalPages,
    };
