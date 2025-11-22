// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_product_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FavoriteProductToggleRequest _$FavoriteProductToggleRequestFromJson(
    Map<String, dynamic> json) {
  return _FavoriteProductToggleRequest.fromJson(json);
}

/// @nodoc
mixin _$FavoriteProductToggleRequest {
  String get productId => throw _privateConstructorUsedError;

  /// Serializes this FavoriteProductToggleRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FavoriteProductToggleRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FavoriteProductToggleRequestCopyWith<FavoriteProductToggleRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoriteProductToggleRequestCopyWith<$Res> {
  factory $FavoriteProductToggleRequestCopyWith(
          FavoriteProductToggleRequest value,
          $Res Function(FavoriteProductToggleRequest) then) =
      _$FavoriteProductToggleRequestCopyWithImpl<$Res,
          FavoriteProductToggleRequest>;

  @useResult
  $Res call({String productId});
}

/// @nodoc
class _$FavoriteProductToggleRequestCopyWithImpl<$Res,
        $Val extends FavoriteProductToggleRequest>
    implements $FavoriteProductToggleRequestCopyWith<$Res> {
  _$FavoriteProductToggleRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoriteProductToggleRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
  }) {
    return _then(_value.copyWith(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FavoriteProductToggleRequestImplCopyWith<$Res>
    implements $FavoriteProductToggleRequestCopyWith<$Res> {
  factory _$$FavoriteProductToggleRequestImplCopyWith(
          _$FavoriteProductToggleRequestImpl value,
          $Res Function(_$FavoriteProductToggleRequestImpl) then) =
      __$$FavoriteProductToggleRequestImplCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({String productId});
}

/// @nodoc
class __$$FavoriteProductToggleRequestImplCopyWithImpl<$Res>
    extends _$FavoriteProductToggleRequestCopyWithImpl<$Res,
        _$FavoriteProductToggleRequestImpl>
    implements _$$FavoriteProductToggleRequestImplCopyWith<$Res> {
  __$$FavoriteProductToggleRequestImplCopyWithImpl(
      _$FavoriteProductToggleRequestImpl _value,
      $Res Function(_$FavoriteProductToggleRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of FavoriteProductToggleRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
  }) {
    return _then(_$FavoriteProductToggleRequestImpl(
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FavoriteProductToggleRequestImpl
    implements _FavoriteProductToggleRequest {
  const _$FavoriteProductToggleRequestImpl({required this.productId});

  factory _$FavoriteProductToggleRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$FavoriteProductToggleRequestImplFromJson(json);

  @override
  final String productId;

  @override
  String toString() {
    return 'FavoriteProductToggleRequest(productId: $productId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoriteProductToggleRequestImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, productId);

  /// Create a copy of FavoriteProductToggleRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoriteProductToggleRequestImplCopyWith<
          _$FavoriteProductToggleRequestImpl>
      get copyWith => __$$FavoriteProductToggleRequestImplCopyWithImpl<
          _$FavoriteProductToggleRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FavoriteProductToggleRequestImplToJson(
      this,
    );
  }
}

abstract class _FavoriteProductToggleRequest
    implements FavoriteProductToggleRequest {
  const factory _FavoriteProductToggleRequest(
      {required final String productId}) = _$FavoriteProductToggleRequestImpl;

  factory _FavoriteProductToggleRequest.fromJson(Map<String, dynamic> json) =
      _$FavoriteProductToggleRequestImpl.fromJson;

  @override
  String get productId;

  /// Create a copy of FavoriteProductToggleRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoriteProductToggleRequestImplCopyWith<
          _$FavoriteProductToggleRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
