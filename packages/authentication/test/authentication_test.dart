import 'package:authentication/authentication.dart';
import 'package:core/core.dart';
import 'package:country_picker/country_picker.dart';
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

void main() {
  late RegistrationCubit cubit;

  setUp(() {
    cubit = RegistrationCubit(
      authRepository: _FakeAuthRepository(),
      countryRepository: _FakeCountryRepository(),
    );
  });

  tearDown(() {
    cubit.close();
  });

  test('initial state selects Egypt as default country', () {
    final state = cubit.state;
    expect(state, isA<RegistrationIdle>());
    final idle = state as RegistrationIdle;
    expect(idle.selectedCountry.countryCode, 'EG');
    expect(idle.selectedCountry.name, 'Egypt');
    expect(idle.phoneCode, '20');
    expect(idle.countryName, 'Egypt');
  });

  test('updateSelectedCountry changes country, phone code and reloads cities',
      () async {
    cubit.updateFullName('John Doe');
    await Future<void>.delayed(Duration.zero);

    cubit.updateSelectedCountry(Country.parse('iq'));
    final idle = cubit.state as RegistrationIdle;

    expect(idle.selectedCountry.countryCode, 'IQ');
    expect(idle.phoneCode, '964');

    await Future<void>.delayed(Duration.zero);
    expect(cubit.state is RegistrationIdle, isTrue);
    expect((cubit.state as RegistrationIdle).cities, isNotEmpty);
  });

  test('updateSelectedCountry clears a previously selected city', () async {
    cubit.updateCity('Cairo');
    await Future<void>.delayed(Duration.zero);

    cubit.updateSelectedCountry(Country.parse('iq'));
    await Future<void>.delayed(Duration.zero);

    final idle = cubit.state as RegistrationIdle;
    expect(idle.city, isEmpty);
    expect(idle.cityError, isNull);
    expect(idle.isFormValid, isFalse);
  });

  test('register with valid fields emits RegistrationOtpRequired', () async {
    cubit.updateFullName('John Doe');
    cubit.updatePhoneNumber('1234567890');
    cubit.updateCity('Cairo');
    cubit.updatePassword('password123');
    cubit.updateConfirmPassword('password123');

    expect((cubit.state as RegistrationIdle).isFormValid, isTrue);

    await cubit.register();

    expect(cubit.state, isA<RegistrationOtpRequired>());
    expect((cubit.state as RegistrationOtpRequired).phoneNumber,
        '+201234567890');
  });

  test('loadInitialCountry loads the detected country', () async {
    await cubit.loadInitialCountry();

    final idle = cubit.state as RegistrationIdle;
    expect(idle.selectedCountry.countryCode, 'EG');

    await Future<void>.delayed(Duration.zero);
    await Future<void>.delayed(Duration.zero);
    expect((cubit.state as RegistrationIdle).cities, isNotEmpty);
  });
}