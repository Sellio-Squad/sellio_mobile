import 'package:authentication/authentication.dart';
import 'package:core/core.dart';
import 'package:sellio_mobile/core/navigate/route_args.dart';

abstract class AppNavigator implements AuthNavigator {
  void pushLogin();

  void pushCreateAccount();

  void replaceWithCreateAccount();

  void pushForgotPassword();

  void pushConfirmPassword(ConfirmPasswordArgs args);

  void pushProductDetails(ProductDetailsArgs args);

  void pushStoreDetails(StoreDetailsArgs args);

  void pushCustomizeProduct(CustomizeProductArgs args);

  void pushAboutStore(AboutStoreArgs args);

  void pushNotifications();

  void pushSearch();

  void pushMyFavorites();

  void pushMyOrders();

  void goToHome();

  void goToCart();

  void goToCustomDesign();

  void goToThrift();

  void goToAccount();

  void goToLogin();

  void pop<T extends Object?>([T? result]);

  void popAndPush(String routeName);

  void replace(String routeName);

  void pushCategoryDetails(CategoryDetailsArgs args);
}
