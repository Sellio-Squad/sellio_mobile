import 'package:authentication/authentication.dart' as auth;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seller/di/injection_container.dart';
import '../localization/l10n/localization_service.dart';
import 'navigation_extensions.dart';
import 'app_routes.dart';
import 'route_args.dart';

class RouteGenerator {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.login.path,
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
      GoRoute(
        name: AppRoutes.home.name,
        path: AppRoutes.home.path,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: Scaffold(
            body: Center(child: Text(context.local.seller_home)),
          ),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('${context.local.error}: ${state.error}'),
      ),
    ),
  );
}
