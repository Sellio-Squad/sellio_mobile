// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_store_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FavoriteStoreResponseImpl _$$FavoriteStoreResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$FavoriteStoreResponseImpl(
      id: json['id'] as String,
      storeId: json['storeId'] as String,
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$FavoriteStoreResponseImplToJson(
        _$FavoriteStoreResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'storeId': instance.storeId,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$FavoriteStoresListResponseImpl _$$FavoriteStoresListResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$FavoriteStoresListResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => FavoriteStoreResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalElements: (json['totalElements'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
    );

Map<String, dynamic> _$$FavoriteStoresListResponseImplToJson(
        _$FavoriteStoresListResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'totalElements': instance.totalElements,
      'page': instance.page,
      'pageSize': instance.pageSize,
      'totalPages': instance.totalPages,
    };
