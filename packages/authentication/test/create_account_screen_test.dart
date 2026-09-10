import 'package:authentication/domain/repository/auth_repository.dart';
import 'package:authentication/l10n/auth_localizations.dart';
import 'package:authentication/presentation/navigation/auth_navigator.dart';
import 'package:authentication/presentation/screen/create_account/create_account_screen.dart';
import 'package:authentication/presentation/screen/create_account/widgets/country_picker_field.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAuthRepository implements AuthRepository {
  @override
  Future<Result<void>> register({
    required String fullName,
    required String phoneNumber,
    required String password,
    required String city,
    required String country,
    required String region,
    required String countryCode,
  }) async {
    return const Success(null);
  }

  @override
  Future<Result<void>> login({
    required String phoneNumber,
    required String password,
  }) async {
    return const Success(null);
  }

  @override
  Future<Result<void>> verifyRegistrationOtp({required String otp}) async =>
      const Success(null);

  @override
  Future<Result<String?>> resendOtp() async => const Success(null);

  @override
  Future<Result<void>> sendForgotPasswordOtp({
    required String phoneNumber,
    required String defaultRegion,
  }) async {
    return const Success(null);
  }

  @override
  Future<Result<void>> verifyForgotPasswordOtp({required String otp}) async =>
      const Success(null);

  @override
  Future<Result<void>> resetPassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    return const Success(null);
  }

  @override
  Future<Result<void>> logout() async => const Success(null);

  @override
  Future<void> clearAuthData() async {}

  @override
  Future<bool> isLoggedIn() async => false;

  @override
  Future<Result<void>> loginAsGuest() async => const Success(null);

  @override
  Future<bool> isGuestMode() async => false;

  @override
  Future<void> clearGuestMode() async {}

  @override
  Future<String?> getPendingRegistrationPhone() async => null;

  @override
  Future<void> clearPendingRegistration() async {}
}

class _FakeCountryRepository implements CountryRepository {
  @override
  Future<String> getCurrentCountryCode() async => 'eg';

  @override
  Future<Result<List<String>>> getCitiesByCountryIso2(String iso2) async {
    return const Success(['Cairo', 'Giza', 'Baghdad', 'Basra']);
  }
}

class _FakeAuthNavigator implements AuthNavigator {
  @override
  void pushLogin() {}

  @override
  void pushCreateAccount() {}

  @override
  void pushForgotPassword() {}

  @override
  Future<void> pushOtp({
    required String phoneNumber,
    required Future<Result<void>> Function(String otp) onVerify,
    required VoidCallback onVerifySuccess,
  }) async {}

  @override
  void pushResetPassword() {}

  @override
  void goToHome() {}

  @override
  void goToLogin() {}

  @override
  void pop<T extends Object?>([T? result]) {}
}

void main() {
  Widget buildApp() {
    return SellioThemeProvider(
      brightness: Brightness.light,
      child: MaterialApp(
        locale: const Locale('en'),
        supportedLocales: const [Locale('en')],
        localizationsDelegates: const [AuthLocalizations.delegate],
        home: CreateAccountScreen(
          authRepository: _FakeAuthRepository(),
          countryRepository: _FakeCountryRepository(),
          navigator: _FakeAuthNavigator(),
          showCloseButton: false,
        ),
      ),
    );
  }

  testWidgets('create account form renders the country picker field',
      (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pump();
    await tester.pump();

    expect(find.byType(CountryPickerField), findsOneWidget);
  });

  testWidgets('country picker shows the detected country as selected',
      (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pump();
    await tester.pump();

    expect(find.text('Egypt'), findsOneWidget);
  });
}