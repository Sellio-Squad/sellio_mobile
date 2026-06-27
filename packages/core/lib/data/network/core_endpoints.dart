class CoreEndpoints {
  CoreEndpoints._();

  static const String _apiVersion = '/v1';

  static String citiesByCountryIso2(String iso2) =>
      '$_apiVersion/countries/$iso2/cities';
}
