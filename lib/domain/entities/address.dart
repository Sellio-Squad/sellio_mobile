class Address {
  final String id;
  final String country;
  final String city;

  const Address({
    required this.id,
    required this.country,
    required this.city,
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
    );
  }

  factory Address.dummy({int index = 0}) {
    return Address(
      id: 'address_$index',
      country: 'Country ${index + 1}',
      city: 'City ${index + 1}',
    );
  }

  static List<Address> dummyList({int count = 3}) {
    return List.generate(count, (i) => Address.dummy(index: i));
  }
}
