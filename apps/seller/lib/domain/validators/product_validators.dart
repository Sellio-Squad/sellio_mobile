import 'package:core/core.dart';

import 'product_validation_error.dart';

abstract class ProductValidators {
  ProductValidators._();

  static ValidationResult validateTitle(String? title) {
    if (!ValidatorUtils.isNotEmpty(title)) {
      return const ValidationResult.invalid(
          ProductValidationError.titleRequired);
    }
    return const ValidationResult.valid();
  }

  static ValidationResult validateDescription(String? description) {
    if (!ValidatorUtils.isNotEmpty(description)) {
      return const ValidationResult.invalid(
          ProductValidationError.descriptionRequired);
    }
    return const ValidationResult.valid();
  }

  static ValidationResult validateMainImage(String? imagePath) {
    if (!ValidatorUtils.isNotEmpty(imagePath)) {
      return const ValidationResult.invalid(
          ProductValidationError.imageRequired);
    }
    return const ValidationResult.valid();
  }

  static ValidationResult validatePrice(double price) {
    if (price <= 0) {
      return const ValidationResult.invalid(
          ProductValidationError.priceInvalid);
    }
    return const ValidationResult.valid();
  }

  static ValidationResult validateCategory(String? categoryId) {
    if (!ValidatorUtils.isNotEmpty(categoryId)) {
      return const ValidationResult.invalid(
          ProductValidationError.categoryRequired);
    }
    return const ValidationResult.valid();
  }
}
