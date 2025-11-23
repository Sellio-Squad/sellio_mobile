class Address {
  final String? id;
  final String country;
  final String city;

  const Address({
    this.id,
    required this.country,
    required this.city,
  });

  String get fullAddress => '$city, $country';

  Address copyWith({
    String? id,
    String? country,
    String? city,
  }) {
    return Address(
      id: id ?? this.id,
      country: country ?? this.country,
      city: city ?? this.city,
    );
  }
}
