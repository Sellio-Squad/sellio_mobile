import 'package:authentication/authentication.dart' as auth;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seller/di/injection_container.dart';
import 'package:seller/presentation/screens/account/account_screen.dart';
import 'package:seller/presentation/screens/create_product/create_product_screen.dart';
import 'package:seller/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:seller/presentation/screens/main/seller_dashboard.dart';
import 'package:seller/presentation/screens/orders/orders_screen.dart';
import 'package:seller/presentation/screens/products/products_screen.dart';
import '../localization/l10n/localization_service.dart';
import 'navigation_extensions.dart';
import 'app_routes.dart';
import 'route_args.dart';

class RouteGenerator {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _dashboardNavigatorKey = GlobalKey<NavigatorState>();
  static final _ordersNavigatorKey = GlobalKey<NavigatorState>();
  static final _createProductNavigatorKey = GlobalKey<NavigatorState>();
  static final _productsNavigatorKey = GlobalKey<NavigatorState>();
  static final _accountNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.dashboard.path,
    routes: [
      GoRoute(
        name: AppRoutes.login.name,
        path: AppRoutes.login.path,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: auth.LoginScreen(
            authRepository: sl(),
            countryRepository: sl(),
            authenticationCubit: sl(),
            navigator: context.navigator,
          ),
        ),
      ),
      GoRoute(
        name: AppRoutes.register.name,
        path: AppRoutes.register.path,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: auth.CreateAccountScreen(
            authRepository: sl(),
            countryRepository: sl(),
            navigator: context.navigator,
          ),
        ),
      ),
      GoRoute(
        name: AppRoutes.forgotPassword.name,
        path: AppRoutes.forgotPassword.path,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: auth.ForgotPasswordScreen(
            authRepository: sl(),
            countryRepository: sl(),
            navigator: context.navigator,
          ),
        ),
      ),
      GoRoute(
        name: AppRoutes.otp.name,
        path: AppRoutes.otp.path,
        pageBuilder: (context, state) {
          final args = state.extra as OtpArgs;
          return MaterialPage(
            key: state.pageKey,
            child: auth.OtpScreen(
              title: args.title ?? context.local.confirm_your_account,
              subtitle: args.subtitle ??
                  context.local.enter_the_4_digit_sent_to(args.phoneNumber),
              phoneNumber: args.phoneNumber,
              onVerify: args.onVerify,
              onVerifySuccess: args.onVerifySuccess,
              authRepository: sl(),
              navigator: context.navigator,
            ),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.resetPassword.name,
        path: AppRoutes.resetPassword.path,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: auth.ResetPasswordScreen(
            authRepository: sl(),
            countryRepository: sl(),
            navigator: context.navigator,
          ),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          return SellerDashboard(
            key: state.pageKey,
            navigationShell: navigationShell,
          );
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _dashboardNavigatorKey,
            routes: [
              GoRoute(
                name: AppRoutes.dashboard.name,
                path: AppRoutes.dashboard.path,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: const DashboardScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _ordersNavigatorKey,
            routes: [
              GoRoute(
                name: AppRoutes.orders.name,
                path: AppRoutes.orders.path,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: const OrdersScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _createProductNavigatorKey,
            routes: [
              GoRoute(
                name: AppRoutes.createProduct.name,
                path: AppRoutes.createProduct.path,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: const CreateProductScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _productsNavigatorKey,
            routes: [
              GoRoute(
                name: AppRoutes.products.name,
                path: AppRoutes.products.path,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: const ProductsScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _accountNavigatorKey,
            routes: [
              GoRoute(
                name: AppRoutes.account.name,
                path: AppRoutes.account.path,
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  child: const AccountScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('${context.local.error}: ${state.error}'),
      ),
    ),
  );
}
