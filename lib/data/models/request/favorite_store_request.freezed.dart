// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_store_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FavoriteStoreToggleRequest _$FavoriteStoreToggleRequestFromJson(
    Map<String, dynamic> json) {
  return _FavoriteStoreToggleRequest.fromJson(json);
}

/// @nodoc
mixin _$FavoriteStoreToggleRequest {
  String get storeId => throw _privateConstructorUsedError;

  /// Serializes this FavoriteStoreToggleRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FavoriteStoreToggleRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavoriteStoreToggleRequestCopyWith<FavoriteStoreToggleRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteStoreToggleRequestCopyWith<$Res> {
  factory $FavoriteStoreToggleRequestCopyWith(FavoriteStoreToggleRequest value,
          $Res Function(FavoriteStoreToggleRequest) then) =
      _$FavoriteStoreToggleRequestCopyWithImpl<$Res,
          FavoriteStoreToggleRequest>;

  @useResult
  $Res call({String storeId});
}

/// @nodoc
class _$FavoriteStoreToggleRequestCopyWithImpl<$Res,
        $Val extends FavoriteStoreToggleRequest>
    implements $FavoriteStoreToggleRequestCopyWith<$Res> {
  _$FavoriteStoreToggleRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoriteStoreToggleRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
  }) {
    return _then(_value.copyWith(
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FavoriteStoreToggleRequestImplCopyWith<$Res>
    implements $FavoriteStoreToggleRequestCopyWith<$Res> {
  factory _$$FavoriteStoreToggleRequestImplCopyWith(
          _$FavoriteStoreToggleRequestImpl value,
          $Res Function(_$FavoriteStoreToggleRequestImpl) then) =
      __$$FavoriteStoreToggleRequestImplCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({String storeId});
}

/// @nodoc
class __$$FavoriteStoreToggleRequestImplCopyWithImpl<$Res>
    extends _$FavoriteStoreToggleRequestCopyWithImpl<$Res,
        _$FavoriteStoreToggleRequestImpl>
    implements _$$FavoriteStoreToggleRequestImplCopyWith<$Res> {
  __$$FavoriteStoreToggleRequestImplCopyWithImpl(
      _$FavoriteStoreToggleRequestImpl _value,
      $Res Function(_$FavoriteStoreToggleRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoriteStoreToggleRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
  }) {
    return _then(_$FavoriteStoreToggleRequestImpl(
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FavoriteStoreToggleRequestImpl implements _FavoriteStoreToggleRequest {
  const _$FavoriteStoreToggleRequestImpl({required this.storeId});

  factory _$FavoriteStoreToggleRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$FavoriteStoreToggleRequestImplFromJson(json);

  @override
  final String storeId;

  @override
  String toString() {
    return 'FavoriteStoreToggleRequest(storeId: $storeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteStoreToggleRequestImpl &&
            (identical(other.storeId, storeId) || other.storeId == storeId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, storeId);

  /// Create a copy of FavoriteStoreToggleRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteStoreToggleRequestImplCopyWith<_$FavoriteStoreToggleRequestImpl>
      get copyWith => __$$FavoriteStoreToggleRequestImplCopyWithImpl<
          _$FavoriteStoreToggleRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FavoriteStoreToggleRequestImplToJson(
      this,
    );
  }
}

abstract class _FavoriteStoreToggleRequest
    implements FavoriteStoreToggleRequest {
  const factory _FavoriteStoreToggleRequest({required final String storeId}) =
      _$FavoriteStoreToggleRequestImpl;

  factory _FavoriteStoreToggleRequest.fromJson(Map<String, dynamic> json) =
      _$FavoriteStoreToggleRequestImpl.fromJson;

  @override
  String get storeId;

  /// Create a copy of FavoriteStoreToggleRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoriteStoreToggleRequestImplCopyWith<_$FavoriteStoreToggleRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
