abstract class AuthEndpoints {
  String get login;
  String get register;
  String get verifyOtp;
  String get resendOtp;
  String get forgotPassword;
  String get verifyForgotPasswordOtp;
  String get resetForgotPassword;
  
  // User profile related endpoints
  String userProfile();
  String userUpdate();
  String userChangePassword();
  String get resetPassword;
  String userDelete();
  String userAvatar();
  
  // Address related endpoints
  String userAddress();
  String addressById(String addressId);
}
