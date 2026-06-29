import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ProductDetailsArgs {
  ProductDetailsArgs({
    required this.productId,
  });

  final String productId;
}

class StoreDetailsArgs {
  StoreDetailsArgs({required this.storeId});

  final String storeId;
}

class OtpArgs {
  final String phoneNumber;
  final String? title;
  final String? subtitle;
  final Future<Result<void>> Function(String otp) onVerify;
  final VoidCallback onVerifySuccess;

  OtpArgs({
    required this.phoneNumber,
    this.title,
    this.subtitle,
    required this.onVerify,
    required this.onVerifySuccess,
  });
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

class CategoryDetailsArgs {
  final String categoryId;
  final String categoryName;

  CategoryDetailsArgs({
    required this.categoryId,
    required this.categoryName,
  });
}
