import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_address_request.freezed.dart';
part 'add_address_request.g.dart';

@freezed
class AddAddressRequest with _$AddAddressRequest {
  const factory AddAddressRequest({
    required String country,
    required String city,
  }) = _AddAddressRequest;

  factory AddAddressRequest.fromJson(Map<String, dynamic> json) =>
      _$AddAddressRequestFromJson(json);
}
