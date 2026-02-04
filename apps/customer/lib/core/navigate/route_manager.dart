import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sellio_mobile/core/navigate/route_args.dart';
import 'package:sellio_mobile/presentation/screens/auth/create_account/create_account_screen.dart';
import 'package:sellio_mobile/presentation/screens/auth/login/login_screen.dart';
import 'package:sellio_mobile/presentation/screens/cart/cart_screen.dart';
import 'package:sellio_mobile/presentation/screens/customize_product/customize_your_product_screen.dart';
import 'package:sellio_mobile/presentation/screens/home/home_screen.dart';
import 'package:sellio_mobile/presentation/screens/main/dashboard.dart';
import 'package:sellio_mobile/presentation/screens/notification/notification_screen.dart';
import 'package:sellio_mobile/presentation/screens/product_details/product_details_screen.dart';
import 'package:sellio_mobile/presentation/screens/search/search_screen.dart';
import 'package:sellio_mobile/presentation/screens/store_details/about_store/about_store.dart';
import 'package:sellio_mobile/presentation/screens/store_details/store_details_screen.dart';

import '../../presentation/screens/account/account_screen.dart';
import '../../presentation/screens/account/myFav/myFavorites.dart';
import '../../presentation/screens/auth/forgot_password/confirm_password_screen.dart';
import '../../presentation/screens/auth/forgot_password/forget_password_screen.dart';
import '../../presentation/screens/more_trending/more_trending_screen.dart';
import '../../presentation/screens/order_history/order_history_screen.dart';
import '../../presentation/screens/thrift/thrift_screen.dart';
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
    initialLocation: AppRoutes.home.path,
    routes: [
      GoRoute(
        name: AppRoutes.login.name,
        path: AppRoutes.login.path,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MaterialPage(
            key: state.pageKey,
            fullscreenDialog: true,
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
        name: AppRoutes.confirmPassword.name,
        path: AppRoutes.confirmPassword.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MaterialPage(
            key: state.pageKey,
            child: const SetNewPasswordScreen(),
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
              productId: args.productId,
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
      GoRoute(
        name: AppRoutes.search.name,
        path: AppRoutes.search.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MaterialPage(
            key: state.pageKey,
            child: const SearchScreen(),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.myOrders.name,
        path: AppRoutes.myOrders.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MaterialPage(
            key: state.pageKey,
            child: const OrderHistoryScreen(),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.myFavorites.name,
        path: AppRoutes.myFavorites.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MaterialPage(
            key: state.pageKey,
            child: const FavoritesScreen(),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.moreTrending.name,
        path: AppRoutes.moreTrending.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return MaterialPage(
            key: state.pageKey,
            child: const MoreTrendingScreen(),
          );
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    ),
  );
}
