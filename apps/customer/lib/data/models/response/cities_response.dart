class CitiesResponse {
  final List<String> cities;
  final String? country;

  CitiesResponse({
    required this.cities,
    this.country,
  });

  factory CitiesResponse.fromJson(Map<String, dynamic> json) {
    return CitiesResponse(
      cities: List<String>.from(json['cities'] ?? []),
      country: json['country'],
    );
  }
}