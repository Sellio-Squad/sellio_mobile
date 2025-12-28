enum AppRoutes {
  // Auth routes
  login(
    name: 'login',
    path: '/',
  ),
  createAccount(
    name: 'createAccount',
    path: '/createAccount',
  ),
  forgetPassword(
    name: 'forget_password',
    path: '/forget_password',
  ),
  confirmPassword(
    name: 'confirmPassword',
    path: '/confirmPassword',
  ),

  // Main routes (StatefulShellRoute branches)
  home(
    name: 'home',
    path: '/home',
  ),
  cart(
    name: 'cart',
    path: '/cart',
  ),
  customDesign(
    name: 'customDesign',
    path: '/customDesign',
  ),
  thrift(
    name: 'thrift',
    path: '/thrift',
  ),
  account(
    name: 'account',
    path: '/account',
  ),

  // Detail routes
  productDetails(
    name: 'productDetails',
    path: '/productDetails',
  ),
  storeDetails(
    name: 'storeDetails',
    path: '/storeDetails',
  ),
  customizeProduct(
    name: 'customizeProduct',
    path: '/customizeProduct',
  ),
  aboutStore(
    name: 'aboutStore',
    path: '/aboutStore',
  ),
  notifications(
    name: 'notifications',
    path: '/notifications',
  ),
  search(
    name: 'search',
    path: '/search',
  ),
  myOrders(
    name: 'myOrders',
    path: '/myOrders',
  ),
  myFavorites(
    name: 'myFavorites',
    path: '/myFavorites',
  );

  const AppRoutes({
    required this.name,
    required this.path,
  });

  final String name;

  final String path;

  @override
  String toString() => name;
}
