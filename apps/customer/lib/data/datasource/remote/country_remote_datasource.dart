import '../../core/api/api_client.dart';
import '../../core/api/api_endpoints.dart';
import '../../models/response/cities_response.dart';

abstract class CountryRemoteDataSource {
  Future<List<String>> getCitiesByCountryIso2(String iso2);
}

class CountryRemoteDataSourceImpl implements CountryRemoteDataSource {
  final ApiClient _httpClient;
  CountryRemoteDataSourceImpl(this._httpClient);

  @override
  Future<List<String>> getCitiesByCountryIso2(String iso2) async {
    final response = await _httpClient.get(
      ApiEndpoints.citiesByCountryIso2(iso2),
    );

    if (response.data is Map<String, dynamic>) {
      final citiesResponse = CitiesResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
      return citiesResponse.cities;
    } else if (response.data is List) {
      return List<String>.from(response.data as List);
    }

    return [];
  }
}
