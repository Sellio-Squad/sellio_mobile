class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://app.sell-io.app';
  static const String apiVersion = '/v1';

  static String citiesByCountryIso2(String iso2) =>
      '$apiVersion/countries/$iso2/cities';

  // Seller
  static const String createStore = '$apiVersion/stores/create';
  static const String sellerOrders = '$apiVersion/seller/orders';

  //Create product
  static const String createProduct = '$apiVersion/products/create';
  static const String storeOwner = '$apiVersion/stores/owner';

  // Categories
  static const String categoriesAll = '$apiVersion/category/all-categories';
}
