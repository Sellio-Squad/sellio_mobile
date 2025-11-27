import '../../../core/error/failure.dart';
import '../../../core/error/result.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../mock_data_generator.dart';

class MockAuthRepositoryImpl implements AuthRepository {
  // Store logged user
  User? _currentUser;
  String? _authToken;

  /// userKey = +countryCode + phone_number
  final Map<String, String> _registeredUsers = {};

  /// Used for password reset verification
  String? _pendingPhone;
  String? _pendingCountry;
  String _generatedOtp = "123456";   // default OTP

  Future<void> _delay() async => await Future.delayed(const Duration(milliseconds: 800));

  // -----------------------------------------------------------
  // LOGIN
  // -----------------------------------------------------------
  @override
  Future<Result<User>> login({
    required String phoneNumber,
    required String countryCode,
    required String password,
  }) async {
    await _delay();
    final key = '$countryCode$phoneNumber';

    if (!_registeredUsers.containsKey(key) || _registeredUsers[key] != password) {
      return const ResultFailure(AuthenticationFailure(message: "Incorrect phone or password"));
    }

    _currentUser = MockDataGenerator.generateUser(index: 0);
    _authToken = "token_${DateTime.now().millisecondsSinceEpoch}";

    return Success(_currentUser!);
  }

  // -----------------------------------------------------------
  // REGISTER USER
  // -----------------------------------------------------------
  @override
  Future<Result<User>> register({
    required String fullName,
    required String phoneNumber,
    required String countryCode,
    required String password,
    required String country,
    required String city,
    String? profilePhotoUrl,
  }) async {
    await _delay();

    if (fullName.isEmpty || phoneNumber.isEmpty || password.isEmpty) {
      return const ResultFailure(ValidationFailure(message: "All fields are required"));
    }

    final key = '$countryCode$phoneNumber';

    if (_registeredUsers.containsKey(key)) {
      return const ResultFailure(ValidationFailure(message: "User already exists"));
    }

    _registeredUsers[key] = password;
    _currentUser = MockDataGenerator.generateUser(index: 0);
    _authToken = "token_${DateTime.now().millisecondsSinceEpoch}";

    return Success(_currentUser!);
  }

  // -----------------------------------------------------------
  // SEND FORGOT PASSWORD OTP
  // -----------------------------------------------------------
  @override
  Future<Result<void>> sendForgotPasswordOtp({
    required String phoneNumber,
    required String countryCode,
  }) async {
    await _delay();

    _pendingPhone = phoneNumber;
    _pendingCountry = countryCode;

    // Generate fixed OTP for local testing
    _generatedOtp = "123456";

    print("📩 OTP Sent to $countryCode$phoneNumber → $_generatedOtp");
    return const Success(null);
  }

  // -----------------------------------------------------------
  // OTP VERIFICATION
  // -----------------------------------------------------------
  @override
  Future<Result<bool>> verifyOtp({
    required String phoneNumber,
    required String countryCode,
    required String otpCode,
  }) async {
    await _delay();

    if (otpCode == _generatedOtp && phoneNumber == _pendingPhone && countryCode == _pendingCountry) {
      return const Success(true);
    }

    return const ResultFailure(ValidationFailure(message: "Incorrect OTP"));
  }

  // -----------------------------------------------------------
  // RESEND OTP
  // -----------------------------------------------------------
  @override
  Future<Result<void>> resendOtp({
    required String phoneNumber,
    required String countryCode,
  }) async {
    await _delay();
    _generatedOtp = "123456"; // new OTP can be changed
    print("🔄 OTP Re-sent → $_generatedOtp");
    return const Success(null);
  }

  // -----------------------------------------------------------
  // RESET PASSWORD
  // -----------------------------------------------------------
  @override
  Future<Result<void>> resetPassword({
    required String phoneNumber,
    required String countryCode,
    required String otpCode,
    required String newPassword,
  }) async {
    await _delay();

    if (otpCode != _generatedOtp) {
      return const ResultFailure(ValidationFailure(message: "Invalid OTP"));
    }

    final key = '$countryCode$phoneNumber';
    _registeredUsers[key] = newPassword;

    print("🔑 Password updated successfully for $key");

    return const Success(null);
  }

  // -----------------------------------------------------------
  // EXTRA AUTH OPERATIONS
  // -----------------------------------------------------------
  @override
  Future<Result<void>> logout() async {
    await _delay();
    _currentUser = null;
    _authToken = null;
    return const Success(null);
  }

  @override
  Future<Result<User?>> getCurrentUser() async {
    await _delay();
    return Success(_currentUser);
  }

  @override
  Future<Result<bool>> isLoggedIn() async {
    return Success(_currentUser != null && _authToken != null);
  }

  @override
  Future<Result<String?>> getAuthToken() async {
    return Success(_authToken);
  }
}
