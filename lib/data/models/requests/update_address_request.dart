import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_address_request.freezed.dart';
part 'update_address_request.g.dart';

@freezed
class UpdateAddressRequest with _$UpdateAddressRequest {
  const factory UpdateAddressRequest({
    String? country,
    String? city,
  }) = _UpdateAddressRequest;

  factory UpdateAddressRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateAddressRequestFromJson(json);
}
