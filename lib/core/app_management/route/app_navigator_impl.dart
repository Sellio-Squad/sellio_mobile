import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:sellio_mobile/core/app_management/route/route_args.dart';

import 'app_navigator.dart';
import 'app_routes.dart';

class AppNavigatorImpl implements AppNavigator {
  AppNavigatorImpl(this.context);

  final BuildContext context;

  @override
  void pushLogin() {
    context.pushNamed(AppRoutes.login.name);
  }

  @override
  void replaceWithLogin() {
    context.go(AppRoutes.login.path);
  }

  @override
  void pushCreateAccount() {
    context.pushNamed(AppRoutes.createAccount.name);
  }

  @override
  void replaceWithCreateAccount() {
    context.pushReplacement(AppRoutes.createAccount.path);
  }

  @override
  void pushForgetPassword() {
    context.pushNamed(AppRoutes.forgetPassword.name);
  }

  @override
  void pushForgetPasswordOtp(ForgetPasswordOtpArgs args) {
    context.pushNamed(
      AppRoutes.forgetPasswordOtp.name,
      extra: args,
    );
  }

  @override
  void pushConfirmPassword(ConfirmPasswordArgs args) {
    context.pushNamed(
      AppRoutes.confirmPassword.name,
      extra: args,
    );
  }

  @override
  void pushSignupOtp(SignupOtpArgs args) {
    context.pushNamed(
      AppRoutes.signupOtp.name,
      extra: args,
    );
  }

  @override
  void pushProductDetails(ProductDetailsArgs args) {
    context.pushNamed(
      AppRoutes.productDetails.name,
      extra: args,
    );
  }

  @override
  void pushStoreDetails(StoreDetailsArgs args) {
    context.pushNamed(
      AppRoutes.storeDetails.name,
      extra: args,
    );
  }

  @override
  void pushCustomizeProduct(CustomizeProductArgs args) {
    context.pushNamed(
      AppRoutes.customizeProduct.name,
      extra: args,
    );
  }

  @override
  void pushAboutStore(AboutStoreArgs args) {
    context.pushNamed(
      AppRoutes.aboutStore.name,
      extra: args,
    );
  }

  @override
  void pushNotifications() {
    context.pushNamed(AppRoutes.notifications.name);
  }

  @override
  void goToHome() {
    context.go(AppRoutes.home.path);
  }

  @override
  void goToCart() {
    context.go(AppRoutes.cart.path);
  }

  @override
  void goToCustomDesign() {
    context.go(AppRoutes.customDesign.path);
  }

  @override
  void goToThrift() {
    context.go(AppRoutes.thrift.path);
  }

  @override
  void goToAccount() {
    context.go(AppRoutes.account.path);
  }

  // Navigation utilities
  @override
  void pop<T extends Object?>([T? result]) {
    context.pop<T>(result);
  }

  @override
  void popAndPush(String routeName) {
    context.pop();
    context.pushNamed(routeName);
  }

  @override
  void replace(String routeName) {
    context.pushReplacement(routeName);
  }
}
