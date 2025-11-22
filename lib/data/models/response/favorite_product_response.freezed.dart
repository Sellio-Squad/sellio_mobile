// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_product_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FavoriteProductResponse _$FavoriteProductResponseFromJson(
    Map<String, dynamic> json) {
  return _FavoriteProductResponse.fromJson(json);
}

/// @nodoc
mixin _$FavoriteProductResponse {
  String get id => throw _privateConstructorUsedError;

  String get productId => throw _privateConstructorUsedError;

  String get userId => throw _privateConstructorUsedError;

  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this FavoriteProductResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FavoriteProductResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavoriteProductResponseCopyWith<FavoriteProductResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteProductResponseCopyWith<$Res> {
  factory $FavoriteProductResponseCopyWith(FavoriteProductResponse value,
          $Res Function(FavoriteProductResponse) then) =
      _$FavoriteProductResponseCopyWithImpl<$Res, FavoriteProductResponse>;

  @useResult
  $Res call({String id, String productId, String userId, DateTime createdAt});
}

/// @nodoc
class _$FavoriteProductResponseCopyWithImpl<$Res,
        $Val extends FavoriteProductResponse>
    implements $FavoriteProductResponseCopyWith<$Res> {
  _$FavoriteProductResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoriteProductResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? userId = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
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
abstract class _$$FavoriteProductResponseImplCopyWith<$Res>
    implements $FavoriteProductResponseCopyWith<$Res> {
  factory _$$FavoriteProductResponseImplCopyWith(
          _$FavoriteProductResponseImpl value,
          $Res Function(_$FavoriteProductResponseImpl) then) =
      __$$FavoriteProductResponseImplCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({String id, String productId, String userId, DateTime createdAt});
}

/// @nodoc
class __$$FavoriteProductResponseImplCopyWithImpl<$Res>
    extends _$FavoriteProductResponseCopyWithImpl<$Res,
        _$FavoriteProductResponseImpl>
    implements _$$FavoriteProductResponseImplCopyWith<$Res> {
  __$$FavoriteProductResponseImplCopyWithImpl(
      _$FavoriteProductResponseImpl _value,
      $Res Function(_$FavoriteProductResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoriteProductResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productId = null,
    Object? userId = null,
    Object? createdAt = null,
  }) {
    return _then(_$FavoriteProductResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
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
class _$FavoriteProductResponseImpl implements _FavoriteProductResponse {
  const _$FavoriteProductResponseImpl(
      {required this.id,
      required this.productId,
      required this.userId,
      required this.createdAt});

  factory _$FavoriteProductResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FavoriteProductResponseImplFromJson(json);

  @override
  final String id;
  @override
  final String productId;
  @override
  final String userId;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'FavoriteProductResponse(id: $id, productId: $productId, userId: $userId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteProductResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, productId, userId, createdAt);

  /// Create a copy of FavoriteProductResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteProductResponseImplCopyWith<_$FavoriteProductResponseImpl>
      get copyWith => __$$FavoriteProductResponseImplCopyWithImpl<
          _$FavoriteProductResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FavoriteProductResponseImplToJson(
      this,
    );
  }
}

abstract class _FavoriteProductResponse implements FavoriteProductResponse {
  const factory _FavoriteProductResponse(
      {required final String id,
      required final String productId,
      required final String userId,
      required final DateTime createdAt}) = _$FavoriteProductResponseImpl;

  factory _FavoriteProductResponse.fromJson(Map<String, dynamic> json) =
      _$FavoriteProductResponseImpl.fromJson;

  @override
  String get id;

  @override
  String get productId;

  @override
  String get userId;

  @override
  DateTime get createdAt;

  /// Create a copy of FavoriteProductResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoriteProductResponseImplCopyWith<_$FavoriteProductResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

FavoriteProductsListResponse _$FavoriteProductsListResponseFromJson(
    Map<String, dynamic> json) {
  return _FavoriteProductsListResponse.fromJson(json);
}

/// @nodoc
mixin _$FavoriteProductsListResponse {
  List<FavoriteProductResponse> get data => throw _privateConstructorUsedError;

  int get totalElements => throw _privateConstructorUsedError;

  int get page => throw _privateConstructorUsedError;

  int get pageSize => throw _privateConstructorUsedError;

  int get totalPages => throw _privateConstructorUsedError;

  /// Serializes this FavoriteProductsListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FavoriteProductsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavoriteProductsListResponseCopyWith<FavoriteProductsListResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteProductsListResponseCopyWith<$Res> {
  factory $FavoriteProductsListResponseCopyWith(
          FavoriteProductsListResponse value,
          $Res Function(FavoriteProductsListResponse) then) =
      _$FavoriteProductsListResponseCopyWithImpl<$Res,
          FavoriteProductsListResponse>;

  @useResult
  $Res call(
      {List<FavoriteProductResponse> data,
      int totalElements,
      int page,
      int pageSize,
      int totalPages});
}

/// @nodoc
class _$FavoriteProductsListResponseCopyWithImpl<$Res,
        $Val extends FavoriteProductsListResponse>
    implements $FavoriteProductsListResponseCopyWith<$Res> {
  _$FavoriteProductsListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoriteProductsListResponse
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
              as List<FavoriteProductResponse>,
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
abstract class _$$FavoriteProductsListResponseImplCopyWith<$Res>
    implements $FavoriteProductsListResponseCopyWith<$Res> {
  factory _$$FavoriteProductsListResponseImplCopyWith(
          _$FavoriteProductsListResponseImpl value,
          $Res Function(_$FavoriteProductsListResponseImpl) then) =
      __$$FavoriteProductsListResponseImplCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call(
      {List<FavoriteProductResponse> data,
      int totalElements,
      int page,
      int pageSize,
      int totalPages});
}

/// @nodoc
class __$$FavoriteProductsListResponseImplCopyWithImpl<$Res>
    extends _$FavoriteProductsListResponseCopyWithImpl<$Res,
        _$FavoriteProductsListResponseImpl>
    implements _$$FavoriteProductsListResponseImplCopyWith<$Res> {
  __$$FavoriteProductsListResponseImplCopyWithImpl(
      _$FavoriteProductsListResponseImpl _value,
      $Res Function(_$FavoriteProductsListResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoriteProductsListResponse
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
    return _then(_$FavoriteProductsListResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<FavoriteProductResponse>,
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
class _$FavoriteProductsListResponseImpl
    implements _FavoriteProductsListResponse {
  const _$FavoriteProductsListResponseImpl(
      {required final List<FavoriteProductResponse> data,
      required this.totalElements,
      required this.page,
      required this.pageSize,
      required this.totalPages})
      : _data = data;

  factory _$FavoriteProductsListResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$FavoriteProductsListResponseImplFromJson(json);

  final List<FavoriteProductResponse> _data;

  @override
  List<FavoriteProductResponse> get data {
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
    return 'FavoriteProductsListResponse(data: $data, totalElements: $totalElements, page: $page, pageSize: $pageSize, totalPages: $totalPages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteProductsListResponseImpl &&
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

  /// Create a copy of FavoriteProductsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteProductsListResponseImplCopyWith<
          _$FavoriteProductsListResponseImpl>
      get copyWith => __$$FavoriteProductsListResponseImplCopyWithImpl<
          _$FavoriteProductsListResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FavoriteProductsListResponseImplToJson(
      this,
    );
  }
}

abstract class _FavoriteProductsListResponse
    implements FavoriteProductsListResponse {
  const factory _FavoriteProductsListResponse(
      {required final List<FavoriteProductResponse> data,
      required final int totalElements,
      required final int page,
      required final int pageSize,
      required final int totalPages}) = _$FavoriteProductsListResponseImpl;

  factory _FavoriteProductsListResponse.fromJson(Map<String, dynamic> json) =
      _$FavoriteProductsListResponseImpl.fromJson;

  @override
  List<FavoriteProductResponse> get data;

  @override
  int get totalElements;

  @override
  int get page;

  @override
  int get pageSize;

  @override
  int get totalPages;

  /// Create a copy of FavoriteProductsListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoriteProductsListResponseImplCopyWith<
          _$FavoriteProductsListResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
