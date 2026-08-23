import 'package:authentication/authentication.dart' as auth;
import 'package:authentication/presentation/cubits/auth/authentication_cubit.dart';
import 'package:authentication/presentation/cubits/auth/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:seller/di/injection_container.dart';
import 'package:seller/presentation/screen/account/account_screen.dart';
import 'package:seller/presentation/screen/create_product/create_product_screen.dart';
import 'package:seller/presentation/screen/dashboard/dashboard_screen.dart';
import 'package:seller/presentation/screen/main/cubit/store_cubit.dart';
import 'package:seller/presentation/screen/main/cubit/store_state.dart';
import 'package:seller/presentation/screen/main/seller_dashboard.dart';
import 'package:seller/presentation/screen/orders/orders_screen.dart';
import 'package:seller/presentation/screen/products/products_screen.dart';
import 'package:seller/presentation/screen/store_setup/create_store_screen.dart';

import '../localization/l10n/localization_service.dart';
import 'app_routes.dart';
import 'navigation_extensions.dart';
import 'route_args.dart';

class RouteGenerator {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _dashboardNavigatorKey = GlobalKey<NavigatorState>();
  static final _ordersNavigatorKey = GlobalKey<NavigatorState>();
  static final _createProductNavigatorKey = GlobalKey<NavigatorState>();
  static final _productsNavigatorKey = GlobalKey<NavigatorState>();
  static final _accountNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter? _router;

  static GoRouter get router => _router ??= _createRouter();

  static GoRouter _createRouter() {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: AppRoutes.dashboard.path,
      refreshListenable: GoRouterRefreshListenable([
        sl<AuthenticationCubit>(),
        sl<StoreCubit>(),
      ]),
      redirect: (context, state) {
        final authState = sl<AuthenticationCubit>().state;
        final storeState = sl<StoreCubit>().state;

        final authPaths = {
          AppRoutes.login.path,
          AppRoutes.register.path,
          AppRoutes.forgotPassword.path,
          AppRoutes.otp.path,
          AppRoutes.resetPassword.path,
        };

        final bool onLoginPage = authPaths.contains(state.matchedLocation);

        final bool hasStore = storeState is StoreLoaded;
        final bool needsStore = storeState is StoreNotFound;

        if (authState is Guest || authState is RequireLogin) {
          return onLoginPage ? null : AppRoutes.login.path;
        }

        if (authState is! LoggedIn) {
          return null;
        }

        final bool onStoreSetup =
            state.matchedLocation.startsWith(AppRoutes.createStore.path);

        if (needsStore) {
          return onStoreSetup ? null : AppRoutes.createStore.path;
        }

        if (hasStore) {
          return (onLoginPage || onStoreSetup)
              ? AppRoutes.dashboard.path
              : null;
        }

        return null;
      },
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
              showCloseButton: false,
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
              showCloseButton: false,
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
              showBackButton: false,
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
                showBackButton: false,
                showCloseButton: false,
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
              showBackButton: false,
            ),
          ),
        ),
        GoRoute(
          name: AppRoutes.createStore.name,
          path: AppRoutes.createStore.path,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: const CreateStoreScreen(),
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
}

class GoRouterRefreshListenable extends ChangeNotifier {
  GoRouterRefreshListenable(List<BlocBase> blocs) {
    for (final bloc in blocs) {
      bloc.stream.listen((_) {
        if (!hasListeners) return;
        notifyListeners();
      });
    }
  }
}
