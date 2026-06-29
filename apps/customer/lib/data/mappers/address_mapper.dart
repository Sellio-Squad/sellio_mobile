import 'package:authentication/data/models/user/address_model.dart';
import 'package:authentication/domain/entities/address.dart';

extension AddressModelMapper on AddressModel {
  Address toEntity() {
    return Address(
      id: id,
      country: country,
      city: city,
    );
  }
}
