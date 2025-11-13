import '../../domain/entities/address.dart';

class AddressModel extends Address {
  const AddressModel({
    required super.id,
    required super.country,
    required super.city,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country': country,
      'city': city,
    };
  }

  factory AddressModel.fromEntity(Address address) {
    return AddressModel(
      id: address.id,
      country: address.country,
      city: address.city,
    );
  }

  Address toEntity() {
    return Address(
      id: id,
      country: country,
      city: city,
    );
  }
}
