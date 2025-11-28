class ProductDetailsArgs {
  ProductDetailsArgs({
    required this.productId,
  });

  final String productId;
}

class StoreDetailsArgs {
  StoreDetailsArgs({
    required this.storeId,
  });

  final String storeId;
}
class ForgetPasswordOtpArgs {
  ForgetPasswordOtpArgs({
    required this.phoneNumber,
    required this.countryCode,
  });

  final String phoneNumber;
  final String countryCode;
}

/// Used in OTP Screen → SetNewPasswordScreen
class ConfirmPasswordArgs {
  ConfirmPasswordArgs({
    required this.phoneNumber,
    required this.countryCode,
    required this.otp,
  });

  final String phoneNumber;
  final String countryCode;
  final String otp;
}

/// Used in Signup flow → Verify OTP
class SignupOtpArgs {
  SignupOtpArgs({
    required this.sessionId,
    required this.phoneNumber,
    required this.countryCode,
  });

  final String sessionId;
  final String phoneNumber;
  final String countryCode;
}

class CustomizeProductArgs {
  CustomizeProductArgs({
    required this.productId,
    this.productName,
  });

  final String productId;
  final String? productName;
}

class AboutStoreArgs {
  AboutStoreArgs({
    required this.storeId,
  });

  final String storeId;
}
