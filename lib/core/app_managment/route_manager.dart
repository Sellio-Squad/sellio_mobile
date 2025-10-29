import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sellio_mobile/ui/screens/AccountScreen.dart';
import 'package:sellio_mobile/ui/screens/CartScreen.dart';
import 'package:sellio_mobile/ui/screens/CustomDesignScreen.dart';
import 'package:sellio_mobile/ui/screens/SplashScreen.dart';
import 'package:sellio_mobile/ui/screens/ThriftScreen.dart';
import 'package:sellio_mobile/ui/screens/auth/login.dart';
import 'package:sellio_mobile/ui/screens/home/home_screen.dart';
import 'package:sellio_mobile/ui/screens/main_screen/dashboard.dart';

class RoutesPath {

  static const String loginRoute = "/";
  static const String homeRoute = "/home";
  static const String cartRoute = "/cart";
  static const String customDesignRoute = "/customDesign";
  static const String thriftDesignRoute = "/thrift";
  static const String accountRoute = "/account";
}

class RouteGenerator {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _homeNavigatorKey = GlobalKey<NavigatorState>();
  static final _cartNavigatorKey = GlobalKey<NavigatorState>();
  static final _customDesignNavigatorKey = GlobalKey<NavigatorState>();
  static final _thriftNavigatorKey = GlobalKey<NavigatorState>();
  static final _accountNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: RoutesPath.loginRoute,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),

      StatefulShellRoute.indexedStack(
        builder:
            (
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
                path: RoutesPath.homeRoute,
                builder: (BuildContext context, GoRouterState state) {
                  return const HomeScreen();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _cartNavigatorKey,
            routes: <GoRoute>[
              GoRoute(
                path: RoutesPath.cartRoute,
                builder: (BuildContext context, GoRouterState state) =>
                    const CartScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _customDesignNavigatorKey,
            routes: <GoRoute>[
              GoRoute(
                path: RoutesPath.customDesignRoute,
                builder: (BuildContext context, GoRouterState state) =>
                    const CustomDesignScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _thriftNavigatorKey,
            routes: <GoRoute>[
              GoRoute(
                path: RoutesPath.thriftDesignRoute,
                builder: (BuildContext context, GoRouterState state) {
                  return const ThriftScreen();
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _accountNavigatorKey,
            routes: <GoRoute>[
              GoRoute(
                path: RoutesPath.accountRoute,
                builder: (BuildContext context, GoRouterState state) =>
                    const AccountScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
