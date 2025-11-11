// address.dart
class Address {
  final String id;
  final String country;
  final String city;
  final double? latitude;
  final double? longitude;

  const Address({
    required this.id,
    required this.country,
    required this.city,
    this.latitude,
    this.longitude,
  });

  String get fullAddress => '$city, $country';

  Address copyWith({
    String? id,
    String? country,
    String? city,
    double? latitude,
    double? longitude,
  }) {
    return Address(
      id: id ?? this.id,
      country: country ?? this.country,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  factory Address.dummy({int index = 0}) {
    return Address(
      id: 'address_$index',
      country: 'Country ${index + 1}',
      city: 'City ${index + 1}',
      latitude: 30.0 + index,
      longitude: 31.0 + index,
    );
  }

  static List<Address> dummyList({int count = 3}) {
    return List.generate(count, (i) => Address.dummy(index: i));
  }
}
