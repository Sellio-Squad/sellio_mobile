import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:sellio_mobile/core/navigate/route_args.dart';

import 'package:sellio_mobile/presentation/screens/auth/create_account/create_account_screen.dart';
import 'package:sellio_mobile/presentation/screens/auth/forget_password/confirm_password_screen.dart';
import 'package:sellio_mobile/presentation/screens/auth/forget_password/forget_password_otp_screen.dart';
import 'package:sellio_mobile/presentation/screens/auth/forget_password/forget_password_screen.dart';
import 'package:sellio_mobile/presentation/screens/auth/login/login_screen.dart';
import 'package:sellio_mobile/presentation/screens/auth/signupOTP.dart';

import 'package:sellio_mobile/presentation/screens/cart/cart_screen.dart';
import 'package:sellio_mobile/presentation/screens/customize_product/customize_your_product_screen.dart';
import 'package:sellio_mobile/presentation/screens/home/home_screen.dart';
import 'package:sellio_mobile/presentation/screens/main/dashboard.dart';
import 'package:sellio_mobile/presentation/screens/notification/notification_screen.dart';
import 'package:sellio_mobile/presentation/screens/product_details/product_details_screen.dart';
import 'package:sellio_mobile/presentation/screens/store_details/about_store/about_store.dart';
import 'package:sellio_mobile/presentation/screens/store_details/store_details_screen.dart';

import '../../presentation/screens/account/account_screen.dart';
import '../../presentation/screens/account/myFav/myFavorites.dart';
import '../../presentation/screens/order_history/order_history_screen.dart';
import '../../presentation/screens/thrift/thrift_screen.dart';

import 'app_routes.dart';

class RouteGenerator {
  static final GoRouter router = GoRouter(

    initialLocation: AppRoutes.login.path,

    routes: [

      // ---------------- AUTH ---------------- //

      GoRoute(
        name: AppRoutes.login.name,
        path: AppRoutes.login.path,
        builder: (_, __) => const LoginScreen(),
      ),

      GoRoute(
        name: AppRoutes.createAccount.name,
        path: AppRoutes.createAccount.path,
        builder: (_, __) => const CreateAccountScreen(),
      ),

      GoRoute(
        name: AppRoutes.forgetPassword.name,
        path: AppRoutes.forgetPassword.path,
        builder: (_, __) => const ForgetPasswordScreen(),
      ),

      GoRoute(
        name: AppRoutes.forgetPasswordOtp.name,
        path: AppRoutes.forgetPasswordOtp.path,
        builder: (_, state) =>
            ForgetPasswordOTPScreen(args: state.extra as ForgetPasswordOtpArgs),
      ),

      GoRoute(
        name: AppRoutes.confirmPassword.name,
        path: AppRoutes.confirmPassword.path,
        builder: (_, state) =>
            SetNewPasswordScreen(args: state.extra as ConfirmPasswordArgs),
      ),

      GoRoute(
        name: AppRoutes.signupOtp.name,
        path: AppRoutes.signupOtp.path,
        builder: (_, state) =>
            ConfirmAccountScreen(args: state.extra as SignupOtpArgs),
      ),


      // ---------------- MAIN NAV STRUCTURE ---------------- //

      StatefulShellRoute.indexedStack(
        builder: (_, __, nav) => Dashboard(navigationShell: nav),
        branches: [

          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.home.name,
                path: AppRoutes.home.path,
                builder: (_, __) => const HomeScreen(),
              )
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.cart.name,
                path: AppRoutes.cart.path,
                builder: (_, __) => const CartScreen(),
              )
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.customDesign.name,
                path: AppRoutes.customDesign.path,
                builder: (_, __) => const CustomizeYourProductScreen(),
              )
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.thrift.name,
                path: AppRoutes.thrift.path,
                builder: (_, __) => const ThriftScreen(),
              )
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                name: AppRoutes.account.name,
                path: AppRoutes.account.path,
                builder: (_, __) => const AccountScreen(),
              )
            ],
          ),
        ],
      ),


      // ---------------- PRODUCT & STORE ---------------- //

      GoRoute(
        name: AppRoutes.productDetails.name,
        path: AppRoutes.productDetails.path,
        builder: (_, state) =>
            ProductDetailsScreen(productId: (state.extra as ProductDetailsArgs).productId),
      ),

      GoRoute(
        name: AppRoutes.storeDetails.name,
        path: AppRoutes.storeDetails.path,
        builder: (_, state) =>
            StoreDetailsScreen(storeId: (state.extra as StoreDetailsArgs).storeId),
      ),

      GoRoute(
        name: AppRoutes.aboutStore.name,
        path: AppRoutes.aboutStore.path,
        builder: (_, state) =>
            AboutStore(storeId: (state.extra as AboutStoreArgs).storeId),
      ),


      // ---------------- MISC PAGES ---------------- //

      GoRoute(
        name: AppRoutes.notifications.name,
        path: AppRoutes.notifications.path,
        builder: (_, __) => const NotificationScreen(),
      ),

      GoRoute(
        name: AppRoutes.myOrders.name,
        path: AppRoutes.myOrders.path,
        builder: (_, __) => const OrderHistoryScreen(),
      ),

      GoRoute(
        name: AppRoutes.myFavorites.name,
        path: AppRoutes.myFavorites.path,
        builder: (_, __) => const FavoritesScreen(),
      ),

    ],
  );
}
