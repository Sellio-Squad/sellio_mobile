import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sellio_mobile/core/navigate/route_args.dart';
import '../../../presentation/screens/auth/create_account/create_account_screen.dart';
import '../../../presentation/screens/auth/login/login_screen.dart';
import '../../../presentation/screens/auth/signupOTP.dart';
import '../../../presentation/screens/cart/cart_screen.dart';
import '../../../presentation/screens/customize_product/customize_your_product_screen.dart';
import '../../../presentation/screens/home/home_screen.dart';
import '../../../presentation/screens/main/dashboard.dart';
import '../../../presentation/screens/notification/notification_screen.dart';
import '../../../presentation/screens/product_details/product_details_screen.dart';
import '../../../presentation/screens/store_details/about_store/about_store.dart';
import '../../../presentation/screens/store_details/store_details_screen.dart';
import '../../../presentation/screens/thrift_screen.dart';
import '../../../ui/screens/account/account_screen.dart';
import '../../presentation/screens/auth/forget_password/confirm_password_screen.dart';
import '../../presentation/screens/auth/forget_password/forget_password_otp_screen.dart';
import '../../presentation/screens/auth/forget_password/forget_password_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _homeNavigatorKey = GlobalKey<NavigatorState>();
  static final _cartNavigatorKey = GlobalKey<NavigatorState>();
  static final _customDesignNavigatorKey = GlobalKey<NavigatorState>();
  static final _thriftNavigatorKey = GlobalKey<NavigatorState>();
  static final _accountNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.login.path,
    routes: [
      GoRoute(
        name: AppRoutes.login.name,
        path: AppRoutes.login.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MaterialPage(
            key: state.pageKey,
            child: const LoginScreen(),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.createAccount.name,
        path: AppRoutes.createAccount.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MaterialPage(
            key: state.pageKey,
            child: const CreateAccountScreen(),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.forgetPassword.name,
        path: AppRoutes.forgetPassword.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MaterialPage(
            key: state.pageKey,
            child: const ForgetPasswordScreen(),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.forgetPasswordOtp.name,
        path: AppRoutes.forgetPasswordOtp.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final args = state.extra as ForgetPasswordOtpArgs;
          return MaterialPage(
            key: state.pageKey,
            child: ForgetPasswordOTPScreen(
              args: args,
            ),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.confirmPassword.name,
        path: AppRoutes.confirmPassword.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MaterialPage(
            key: state.pageKey,
            child: const SetNewPasswordScreen(),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.signupOtp.name,
        path: AppRoutes.signupOtp.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MaterialPage(
            key: state.pageKey,
            child: const ConfirmAccountScreen(),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return Dashboard(
            key: state.pageKey,
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: <GoRoute>[
              GoRoute(
                name: AppRoutes.home.name,
                path: AppRoutes.home.path,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return MaterialPage(
                    key: state.pageKey,
                    child: const HomeScreen(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _cartNavigatorKey,
            routes: <GoRoute>[
              GoRoute(
                name: AppRoutes.cart.name,
                path: AppRoutes.cart.path,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return MaterialPage(
                    key: state.pageKey,
                    child: const CartScreen(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _customDesignNavigatorKey,
            routes: <GoRoute>[
              GoRoute(
                name: AppRoutes.customDesign.name,
                path: AppRoutes.customDesign.path,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return MaterialPage(
                    key: state.pageKey,
                    child: const CustomizeYourProductScreen(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _thriftNavigatorKey,
            routes: <GoRoute>[
              GoRoute(
                name: AppRoutes.thrift.name,
                path: AppRoutes.thrift.path,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return MaterialPage(
                    key: state.pageKey,
                    child: const ThriftScreen(),
                  );
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _accountNavigatorKey,
            routes: <GoRoute>[
              GoRoute(
                name: AppRoutes.account.name,
                path: AppRoutes.account.path,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return MaterialPage(
                    key: state.pageKey,
                    child: const AccountScreen(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        name: AppRoutes.productDetails.name,
        path: AppRoutes.productDetails.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final args = state.extra as ProductDetailsArgs;
          return MaterialPage(
            key: state.pageKey,
            child: ProductDetailsScreen(
              productCount: args.productCount,
              productDescription: args.productDescription,
              productPrice: args.productPrice,
              productPriceBeforeDiscount: args.productPriceBeforeDiscount,
            ),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.storeDetails.name,
        path: AppRoutes.storeDetails.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final args = state.extra as StoreDetailsArgs;
          return MaterialPage(
            key: state.pageKey,
            child: StoreDetailsScreen(
              storeId: args.storeId,
              coverImage: args.coverImage,
              profileImage: args.profileImage,
              storeName: args.storeName,
              discount: args.discount,
              rating: args.rating,
            ),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.customizeProduct.name,
        path: AppRoutes.customizeProduct.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MaterialPage(
            key: state.pageKey,
            child: const CustomizeYourProductScreen(),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.aboutStore.name,
        path: AppRoutes.aboutStore.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final args = state.extra as AboutStoreArgs;
          return MaterialPage(
            key: state.pageKey,
            child: AboutStore(
              storeId: args.storeId,
            ),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.notifications.name,
        path: AppRoutes.notifications.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MaterialPage(
            key: state.pageKey,
            child: const NotificationScreen(),
          );
        },
      ),
    ],
  );
}
