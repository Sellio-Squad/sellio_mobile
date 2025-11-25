class ProductDetailsArgs {
  ProductDetailsArgs({
    required this.productId,
  });

  final String productId;
}

class StoreDetailsArgs {
  StoreDetailsArgs({
    required this.storeId
  });

  final String storeId;
}

class ForgetPasswordOtpArgs {
  ForgetPasswordOtpArgs({
    required this.phoneNumber,
  });

  final String phoneNumber;
}

class ConfirmPasswordArgs {
  ConfirmPasswordArgs({
    required this.phoneNumber,
    required this.otp,
  });

  final String phoneNumber;
  final String otp;
}

class SignupOtpArgs {
  SignupOtpArgs({
    required this.phoneNumber,
  });

  final String phoneNumber;
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