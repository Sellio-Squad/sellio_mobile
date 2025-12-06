// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_address_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddAddressRequest _$AddAddressRequestFromJson(Map<String, dynamic> json) {
  return _AddAddressRequest.fromJson(json);
}

/// @nodoc
mixin _$AddAddressRequest {
  String get country => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;

  /// Serializes this AddAddressRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddAddressRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddAddressRequestCopyWith<AddAddressRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddAddressRequestCopyWith<$Res> {
  factory $AddAddressRequestCopyWith(
          AddAddressRequest value, $Res Function(AddAddressRequest) then) =
      _$AddAddressRequestCopyWithImpl<$Res, AddAddressRequest>;
  @useResult
  $Res call({String country, String city});
}

/// @nodoc
class _$AddAddressRequestCopyWithImpl<$Res, $Val extends AddAddressRequest>
    implements $AddAddressRequestCopyWith<$Res> {
  _$AddAddressRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddAddressRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? country = null,
    Object? city = null,
  }) {
    return _then(_value.copyWith(
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddAddressRequestImplCopyWith<$Res>
    implements $AddAddressRequestCopyWith<$Res> {
  factory _$$AddAddressRequestImplCopyWith(_$AddAddressRequestImpl value,
          $Res Function(_$AddAddressRequestImpl) then) =
      __$$AddAddressRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String country, String city});
}

/// @nodoc
class __$$AddAddressRequestImplCopyWithImpl<$Res>
    extends _$AddAddressRequestCopyWithImpl<$Res, _$AddAddressRequestImpl>
    implements _$$AddAddressRequestImplCopyWith<$Res> {
  __$$AddAddressRequestImplCopyWithImpl(_$AddAddressRequestImpl _value,
      $Res Function(_$AddAddressRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddAddressRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? country = null,
    Object? city = null,
  }) {
    return _then(_$AddAddressRequestImpl(
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddAddressRequestImpl implements _AddAddressRequest {
  const _$AddAddressRequestImpl({required this.country, required this.city});

  factory _$AddAddressRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddAddressRequestImplFromJson(json);

  @override
  final String country;
  @override
  final String city;

  @override
  String toString() {
    return 'AddAddressRequest(country: $country, city: $city)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddAddressRequestImpl &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.city, city) || other.city == city));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, country, city);

  /// Create a copy of AddAddressRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddAddressRequestImplCopyWith<_$AddAddressRequestImpl> get copyWith =>
      __$$AddAddressRequestImplCopyWithImpl<_$AddAddressRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddAddressRequestImplToJson(
      this,
    );
  }
}

abstract class _AddAddressRequest implements AddAddressRequest {
  const factory _AddAddressRequest(
      {required final String country,
      required final String city}) = _$AddAddressRequestImpl;

  factory _AddAddressRequest.fromJson(Map<String, dynamic> json) =
      _$AddAddressRequestImpl.fromJson;

  @override
  String get country;
  @override
  String get city;

  /// Create a copy of AddAddressRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddAddressRequestImplCopyWith<_$AddAddressRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
