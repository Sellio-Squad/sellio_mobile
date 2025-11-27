import 'package:sellio_mobile/core/navigate/route_args.dart';

abstract class AppNavigator {
  void pushLogin();

  void replaceWithLogin();

  void pushCreateAccount();

  void replaceWithCreateAccount();

  void pushForgetPassword();

  void pushForgetPasswordOtp(ForgetPasswordOtpArgs args);

  void pushConfirmPassword(ConfirmPasswordArgs args);

  void pushSignupOtp(SignupOtpArgs args);

  void pushProductDetails(ProductDetailsArgs args);

  void pushStoreDetails(StoreDetailsArgs args);

  void pushCustomizeProduct(CustomizeProductArgs args);

  void pushAboutStore(AboutStoreArgs args);

  void pushNotifications();

  void pushMyFavorites();

  void pushMyOrders();

  void goToHome();

  void goToCart();

  void goToCustomDesign();

  void goToThrift();

  void goToAccount();

  void pop<T extends Object?>([T? result]);

  void popAndPush(String routeName);

  void replace(String routeName);

  void goToSearch();
}
