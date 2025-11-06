import '../../domain/entities/address.dart';

class AddressModel extends Address {
  const AddressModel({
    required super.id,
    required super.country,
    required super.city,
    super.latitude,
    super.longitude,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country': country,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory AddressModel.fromEntity(Address address) {
    return AddressModel(
      id: address.id,
      country: address.country,
      city: address.city,
      latitude: address.latitude,
      longitude: address.longitude,
    );
  }

  Address toEntity() {
    return Address(
      id: id,
      country: country,
      city: city,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
