// import '../../../core/error/failure.dart';
// import '../../../core/error/result.dart';
// import '../../../domain/entities/auth_tokens.dart';
// import '../../../domain/entities/user.dart';
// import '../../../domain/repositories/auth_repository.dart';
// import '../mock_data_generator.dart';
//
// class MockAuthRepositoryImpl implements AuthRepository {
//   User? _currentUser;
//   String? _authToken;
//   String? _refreshToken;
//   final Map<String, String> _registeredUsers = {};
//   final Map<String, String> _sessionIds = {}; // Map phoneNumber -> sessionId
//
//   // Simulate API delay
//   Future<void> _simulateDelay() async {
//     await Future.delayed(const Duration(milliseconds: 800));
//   }
//
//   @override
//   Future<Result<AuthTokens>> login({
//     required String phoneNumber,
//     required String countryCode,
//     required String password,
//   }) async {
//     await _simulateDelay();
//     print('--- ATTEMPTING LOGIN ---');
//     print('Received countryCode: $countryCode');
//     print('Received phoneNumber: $phoneNumber');
//
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
//     print('Checking for user with key: $userKey');
//     print('Currently registered users: ${_registeredUsers.keys.join(", ")}');
//     if (!_registeredUsers.containsKey(userKey)) {
//       print('>>> LOGIN FAILED: User key not found.');
//       return const ResultFailure(
//         AuthenticationFailure(message: 'Invalid credentials'),
//       );
//     }
//      print('>>> LOGIN SUCCESS: User key found.');
//     _currentUser = MockDataGenerator.generateUser(index: 0);
//     _authToken = 'mock_access_token_${DateTime.now().millisecondsSinceEpoch}';
//     _refreshToken = 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}';
//
//     return Success(AuthTokens(
//       accessToken: _authToken!,
//       refreshToken: _refreshToken!,
//     ));
//   }
//
//   @override
//   Future<Result<String>> register({
//     required String fullName,
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
//     print('--- REGISTERING ---');
//     print('Received countryCode: $countryCode');
//     print('Received phoneNumber: $phoneNumber');
//     print('Storing user with key: $userKey');
//     _registeredUsers[userKey] = password;
//
//     // Generate a mock sessionId
//     final sessionId = 'mock_session_${DateTime.now().millisecondsSinceEpoch}';
//     _sessionIds[userKey] = sessionId;
//
//     return Success(sessionId);
//   }
//
//   @override
//   Future<Result<AuthTokens>> verifyOtp({
//     required String sessionId,
//     required String otp,
//   }) async {
//     await _simulateDelay();
//
//     // Simulate OTP verification (accept any 4-digit code for signup)
//     if (otp.length != 4) {
//       return const ResultFailure(
//         ValidationFailure(message: 'Invalid OTP code'),
//       );
//     }
//
//     // Find the user by sessionId
//     final userKey = _sessionIds.entries
//         .firstWhere(
//           (entry) => entry.value == sessionId,
//           orElse: () => const MapEntry('', ''),
//         )
//         .key;
//
//     if (userKey.isEmpty) {
//       return const ResultFailure(
//         ValidationFailure(message: 'Invalid session'),
//       );
//     }
//
//     // Generate tokens after successful OTP verification
//     _currentUser = MockDataGenerator.generateUser(index: 0);
//     _authToken = 'mock_access_token_${DateTime.now().millisecondsSinceEpoch}';
//     _refreshToken = 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}';
//
//     return Success(AuthTokens(
//       accessToken: _authToken!,
//       refreshToken: _refreshToken!,
//     ));
//   }
//
//   @override
//   Future<Result<void>> resendOtp({
//     required String sessionId,
//   }) async {
//     await _simulateDelay();
//     // In a real implementation, this would trigger a new OTP to be sent
//     // For mock, we just simulate success
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
//     required String otp,
//     required String newPassword,
//   }) async {
//     await _simulateDelay();
//
//     if (otp.length != 6) {
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
//     _refreshToken = null;
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
