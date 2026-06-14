import 'package:authentication/authentication.dart';
import 'api_endpoints.dart';

class CustomerAuthEndpoints implements AuthEndpoints {
  @override
  String get login => ApiEndpoints.login;

  @override
  String get register => ApiEndpoints.register;

  @override
  String get verifyOtp => ApiEndpoints.verifyOtp;

  @override
  String get resendOtp => ApiEndpoints.resendOtp;

  @override
  String get forgotPassword => ApiEndpoints.forgotPassword;

  @override
  String get verifyForgotPasswordOtp => ApiEndpoints.verifyForgotPasswordOtp;

  @override
  String get resetForgotPassword => ApiEndpoints.resetForgotPassword;

  @override
  String userProfile() => ApiEndpoints.userProfile();

  @override
  String userUpdate() => ApiEndpoints.userUpdate();

  @override
  String userChangePassword() => ApiEndpoints.userChangePassword();

  @override
  String get resetPassword => ApiEndpoints.resetPassword;

  @override
  String userDelete() => ApiEndpoints.userDelete();

  @override
  String userAvatar() => ApiEndpoints.userAvatar();

  @override
  String userAddress() => ApiEndpoints.userAddress();

  @override
  String addressById(String addressId) => ApiEndpoints.addressById(addressId);
}
