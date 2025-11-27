// import '../../../core/error/failure.dart';
// import '../../../core/error/result.dart';
// import '../../../domain/entities/user.dart';
// import '../../../domain/repositories/auth_repository.dart';
// import '../mock_data_generator.dart';
//
// class MockAuthRepositoryImpl implements AuthRepository {
//   User? _currentUser;
//   String? _authToken;
//   final Map<String, String> _registeredUsers = {};
//
//   // Simulate API delay
//   Future<void> _simulateDelay() async {
//     await Future.delayed(const Duration(milliseconds: 800));
//   }
//
//   @override
//   Future<Result<User>> login({
//     required String phoneNumber,
//     required String countryCode,
//     required String password,
//   }) async {
//     await _simulateDelay();
//
//     // Simulate validation
//     if (phoneNumber.isEmpty || password.isEmpty) {
//       return const ResultFailure(
//         ValidationFailure(message: 'Phone number and password are required'),
//       );
//     }
//
//     // Simulate authentication
//     final userKey = '$countryCode$phoneNumber';
//     if (!_registeredUsers.containsKey(userKey)) {
//       return const ResultFailure(
//         AuthenticationFailure(message: 'Invalid credentials'),
//       );
//     }
//
//     _currentUser = MockDataGenerator.generateUser(index: 0);
//     _authToken = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
//
//     return Success(_currentUser!);
//   }
//
//   @override
//   Future<Result<String>> createAccount({
//     required String firstName,
//     required String lastName,
//     required String phoneNumber,
//     required String countryCode,
//     required String password,
//     required String country,
//     required String city,
//     String? profilePhotoUrl,
//   }) async {
//     await _simulateDelay();
//
//     // Simulate validation
//     if (fullName.isEmpty || phoneNumber.isEmpty || password.isEmpty) {
//       return const ResultFailure(
//         ValidationFailure(message: 'All fields are required'),
//       );
//     }
//
//     // Register user
//     final userKey = '$countryCode$phoneNumber';
//     _registeredUsers[userKey] = password;
//
//     _currentUser = MockDataGenerator.generateUser(index: 0);
//     _authToken = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';
//
//     return Success(_currentUser!);
//   }
//
//   @override
//   Future<Result<bool>> verifyOtp({
//     required String phoneNumber,
//     required String countryCode,
//     required String otpCode,
//   }) async {
//     await _simulateDelay();
//
//     // Simulate OTP verification (accept any 6-digit code)
//     if (otpCode.length == 6) {
//       return const Success(true);
//     }
//
//     return const ResultFailure(
//       ValidationFailure(message: 'Invalid OTP code'),
//     );
//   }
//
//   @override
//   Future<Result<void>> resendOtp({
//     required String phoneNumber,
//     required String countryCode,
//   }) async {
//     await _simulateDelay();
//     return const Success(null);
//   }
//
//   @override
//   Future<Result<void>> sendForgotPasswordOtp({
//     required String phoneNumber,
//     required String countryCode,
//   }) async {
//     await _simulateDelay();
//     return const Success(null);
//   }
//
//   @override
//   Future<Result<void>> resetPassword({
//     required String phoneNumber,
//     required String countryCode,
//     required String otpCode,
//     required String newPassword,
//   }) async {
//     await _simulateDelay();
//
//     if (otpCode.length != 6) {
//       return const ResultFailure(
//         ValidationFailure(message: 'Invalid OTP code'),
//       );
//     }
//
//     final userKey = '$countryCode$phoneNumber';
//     _registeredUsers[userKey] = newPassword;
//
//     return const Success(null);
//   }
//
//   @override
//   Future<Result<void>> logout() async {
//     await _simulateDelay();
//     _currentUser = null;
//     _authToken = null;
//     return const Success(null);
//   }
//
//   @override
//   Future<Result<User?>> getCurrentUser() async {
//     await _simulateDelay();
//     return Success(_currentUser);
//   }
//
//   @override
//   Future<Result<bool>> isLoggedIn() async {
//     await Future.delayed(const Duration(milliseconds: 200));
//     return Success(_currentUser != null && _authToken != null);
//   }
//
//   @override
//   Future<Result<String?>> getAuthToken() async {
//     await Future.delayed(const Duration(milliseconds: 200));
//     return Success(_authToken);
//   }
// }