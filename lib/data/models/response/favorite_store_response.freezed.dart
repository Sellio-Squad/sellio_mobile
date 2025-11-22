// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_store_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FavoriteStoreResponse _$FavoriteStoreResponseFromJson(
    Map<String, dynamic> json) {
  return _FavoriteStoreResponse.fromJson(json);
}

/// @nodoc
mixin _$FavoriteStoreResponse {
  String get id => throw _privateConstructorUsedError;

  String get storeId => throw _privateConstructorUsedError;

  String get userId => throw _privateConstructorUsedError;

  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this FavoriteStoreResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FavoriteStoreResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavoriteStoreResponseCopyWith<FavoriteStoreResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteStoreResponseCopyWith<$Res> {
  factory $FavoriteStoreResponseCopyWith(FavoriteStoreResponse value,
          $Res Function(FavoriteStoreResponse) then) =
      _$FavoriteStoreResponseCopyWithImpl<$Res, FavoriteStoreResponse>;

  @useResult
  $Res call({String id, String storeId, String userId, DateTime createdAt});
}

/// @nodoc
class _$FavoriteStoreResponseCopyWithImpl<$Res,
        $Val extends FavoriteStoreResponse>
    implements $FavoriteStoreResponseCopyWith<$Res> {
  _$FavoriteStoreResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoriteStoreResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeId = null,
    Object? userId = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FavoriteStoreResponseImplCopyWith<$Res>
    implements $FavoriteStoreResponseCopyWith<$Res> {
  factory _$$FavoriteStoreResponseImplCopyWith(
          _$FavoriteStoreResponseImpl value,
          $Res Function(_$FavoriteStoreResponseImpl) then) =
      __$$FavoriteStoreResponseImplCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({String id, String storeId, String userId, DateTime createdAt});
}

/// @nodoc
class __$$FavoriteStoreResponseImplCopyWithImpl<$Res>
    extends _$FavoriteStoreResponseCopyWithImpl<$Res,
        _$FavoriteStoreResponseImpl>
    implements _$$FavoriteStoreResponseImplCopyWith<$Res> {
  __$$FavoriteStoreResponseImplCopyWithImpl(_$FavoriteStoreResponseImpl _value,
      $Res Function(_$FavoriteStoreResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoriteStoreResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? storeId = null,
    Object? userId = null,
    Object? createdAt = null,
  }) {
    return _then(_$FavoriteStoreResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FavoriteStoreResponseImpl implements _FavoriteStoreResponse {
  const _$FavoriteStoreResponseImpl(
      {required this.id,
      required this.storeId,
      required this.userId,
      required this.createdAt});

  factory _$FavoriteStoreResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FavoriteStoreResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String storeId;
  @override
  final String userId;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'FavoriteStoreResponse(id: $id, storeId: $storeId, userId: $userId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteStoreResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, storeId, userId, createdAt);

  /// Create a copy of FavoriteStoreResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteStoreResponseImplCopyWith<_$FavoriteStoreResponseImpl>
      get copyWith => __$$FavoriteStoreResponseImplCopyWithImpl<
          _$FavoriteStoreResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FavoriteStoreResponseImplToJson(
      this,
    );
  }
}

abstract class _FavoriteStoreResponse implements FavoriteStoreResponse {
  const factory _FavoriteStoreResponse(
      {required final String id,
      required final String storeId,
      required final String userId,
      required final DateTime createdAt}) = _$FavoriteStoreResponseImpl;

  factory _FavoriteStoreResponse.fromJson(Map<String, dynamic> json) =
      _$FavoriteStoreResponseImpl.fromJson;

  @override
  String get id;

  @override
  String get storeId;

  @override
  String get userId;

  @override
  DateTime get createdAt;

  /// Create a copy of FavoriteStoreResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoriteStoreResponseImplCopyWith<_$FavoriteStoreResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

FavoriteStoresListResponse _$FavoriteStoresListResponseFromJson(
    Map<String, dynamic> json) {
  return _FavoriteStoresListResponse.fromJson(json);
}

/// @nodoc
mixin _$FavoriteStoresListResponse {
  List<FavoriteStoreResponse> get data => throw _privateConstructorUsedError;

  int get totalElements => throw _privateConstructorUsedError;

  int get page => throw _privateConstructorUsedError;

  int get pageSize => throw _privateConstructorUsedError;

  int get totalPages => throw _privateConstructorUsedError;

  /// Serializes this FavoriteStoresListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FavoriteStoresListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavoriteStoresListResponseCopyWith<FavoriteStoresListResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteStoresListResponseCopyWith<$Res> {
  factory $FavoriteStoresListResponseCopyWith(FavoriteStoresListResponse value,
          $Res Function(FavoriteStoresListResponse) then) =
      _$FavoriteStoresListResponseCopyWithImpl<$Res,
          FavoriteStoresListResponse>;

  @useResult
  $Res call(
      {List<FavoriteStoreResponse> data,
      int totalElements,
      int page,
      int pageSize,
      int totalPages});
}

/// @nodoc
class _$FavoriteStoresListResponseCopyWithImpl<$Res,
        $Val extends FavoriteStoresListResponse>
    implements $FavoriteStoresListResponseCopyWith<$Res> {
  _$FavoriteStoresListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoriteStoresListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? totalElements = null,
    Object? page = null,
    Object? pageSize = null,
    Object? totalPages = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<FavoriteStoreResponse>,
      totalElements: null == totalElements
          ? _value.totalElements
          : totalElements // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FavoriteStoresListResponseImplCopyWith<$Res>
    implements $FavoriteStoresListResponseCopyWith<$Res> {
  factory _$$FavoriteStoresListResponseImplCopyWith(
          _$FavoriteStoresListResponseImpl value,
          $Res Function(_$FavoriteStoresListResponseImpl) then) =
      __$$FavoriteStoresListResponseImplCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call(
      {List<FavoriteStoreResponse> data,
      int totalElements,
      int page,
      int pageSize,
      int totalPages});
}

/// @nodoc
class __$$FavoriteStoresListResponseImplCopyWithImpl<$Res>
    extends _$FavoriteStoresListResponseCopyWithImpl<$Res,
        _$FavoriteStoresListResponseImpl>
    implements _$$FavoriteStoresListResponseImplCopyWith<$Res> {
  __$$FavoriteStoresListResponseImplCopyWithImpl(
      _$FavoriteStoresListResponseImpl _value,
      $Res Function(_$FavoriteStoresListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoriteStoresListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? totalElements = null,
    Object? page = null,
    Object? pageSize = null,
    Object? totalPages = null,
  }) {
    return _then(_$FavoriteStoresListResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<FavoriteStoreResponse>,
      totalElements: null == totalElements
          ? _value.totalElements
          : totalElements // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FavoriteStoresListResponseImpl implements _FavoriteStoresListResponse {
  const _$FavoriteStoresListResponseImpl(
      {required final List<FavoriteStoreResponse> data,
      required this.totalElements,
      required this.page,
      required this.pageSize,
      required this.totalPages})
      : _data = data;

  factory _$FavoriteStoresListResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$FavoriteStoresListResponseImplFromJson(json);

  final List<FavoriteStoreResponse> _data;

  @override
  List<FavoriteStoreResponse> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final int totalElements;
  @override
  final int page;
  @override
  final int pageSize;
  @override
  final int totalPages;

  @override
  String toString() {
    return 'FavoriteStoresListResponse(data: $data, totalElements: $totalElements, page: $page, pageSize: $pageSize, totalPages: $totalPages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteStoresListResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.totalElements, totalElements) ||
                other.totalElements == totalElements) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_data),
      totalElements,
      page,
      pageSize,
      totalPages);

  /// Create a copy of FavoriteStoresListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteStoresListResponseImplCopyWith<_$FavoriteStoresListResponseImpl>
      get copyWith => __$$FavoriteStoresListResponseImplCopyWithImpl<
          _$FavoriteStoresListResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FavoriteStoresListResponseImplToJson(
      this,
    );
  }
}

abstract class _FavoriteStoresListResponse
    implements FavoriteStoresListResponse {
  const factory _FavoriteStoresListResponse(
      {required final List<FavoriteStoreResponse> data,
      required final int totalElements,
      required final int page,
      required final int pageSize,
      required final int totalPages}) = _$FavoriteStoresListResponseImpl;

  factory _FavoriteStoresListResponse.fromJson(Map<String, dynamic> json) =
      _$FavoriteStoresListResponseImpl.fromJson;

  @override
  List<FavoriteStoreResponse> get data;

  @override
  int get totalElements;

  @override
  int get page;

  @override
  int get pageSize;

  @override
  int get totalPages;

  /// Create a copy of FavoriteStoresListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoriteStoresListResponseImplCopyWith<_$FavoriteStoresListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
