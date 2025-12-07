import '../../domain/entities/address.dart';
import '../models/address_model.dart';

extension AddressModelMapper on AddressModel {
  Address toEntity() {
    return Address(
      id: id,
      country: country,
      city: city,
    );
  }
}
