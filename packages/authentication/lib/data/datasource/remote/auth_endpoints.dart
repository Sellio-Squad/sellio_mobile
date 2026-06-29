abstract class AuthConfiguration {
  String get role;

  static const String _apiVersion = '/v1';

  String get login => '$_apiVersion/auth/login';
  String get register => '$_apiVersion/auth/create';
  String get verifyOtp => '$_apiVersion/auth/create/verify-otp';
  String get resendOtp => '$_apiVersion/auth/resend-otp';
  String get forgotPassword => '$_apiVersion/forgot-password/request';
  String get verifyForgotPasswordOtp => '$_apiVersion/forgot-password/verify';
  String get resetForgotPassword => '$_apiVersion/forgot-password/reset';
  String get resetPassword => '$_apiVersion/auth/reset-password';
  String get refreshToken => '$_apiVersion/auth/refresh-token';

  String userProfile() => '$_apiVersion/user/profile';
  String userUpdate() => '$_apiVersion/user/update';
  String userChangePassword() => '$_apiVersion/user/change-password';
  String userDelete() => '$_apiVersion/user/delete';
  String userAvatar() => '$_apiVersion/user/avatar';
  String userAddress() => '$_apiVersion/user/address';
  String addressById(String addressId) => '$_apiVersion/address/$addressId';
}
