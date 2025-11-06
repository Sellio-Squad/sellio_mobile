
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

  String get fullAddress {
    final parts = <String>[
      city,
      country,
    ];
    return parts.join(', ');
  }

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
}