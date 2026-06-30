class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://app.sell-io.app';
  static const String apiVersion = '/v1';

  static String citiesByCountryIso2(String iso2) =>
      '$apiVersion/countries/$iso2/cities';

  // Seller
  static const String createStore = '$apiVersion/stores/create';
  static const String sellerOrders = '$apiVersion/seller/orders';
}
