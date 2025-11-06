class ProductDetailsArgs {
  ProductDetailsArgs({
    required this.productCount,
    required this.productDescription,
    required this.productPrice,
    this.productPriceBeforeDiscount,
  });

  final int productCount;
  final String productDescription;
  final double productPrice;
  final double? productPriceBeforeDiscount;
}

class StoreDetailsArgs {
  StoreDetailsArgs({
    required this.storeId,
    required this.coverImage,
    required this.profileImage,
    required this.storeName,
    required this.discount,
    required this.rating,
  });

  final String storeId;
  final String coverImage;
  final String profileImage;
  final String storeName;
  final String discount;
  final double rating;
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
