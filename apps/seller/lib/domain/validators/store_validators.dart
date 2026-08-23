import 'package:core/core.dart';

import 'store_validation_error.dart';

abstract class StoreValidators {
  StoreValidators._();

  static ValidationResult validateName(String? name) {
    if (!ValidatorUtils.isNotEmpty(name)) {
      return const ValidationResult.invalid(StoreValidationError.nameRequired);
    }
    if (name!.length < ValidationConstants.minStoreNameLength) {
      return const ValidationResult.invalid(StoreValidationError.nameTooShort);
    }
    if (name.length > ValidationConstants.maxStoreNameLength) {
      return const ValidationResult.invalid(StoreValidationError.nameTooLong);
    }
    return const ValidationResult.valid();
  }

  static ValidationResult validateDescription(String? description) {
    if (!ValidatorUtils.isNotEmpty(description)) {
      return const ValidationResult.invalid(
          StoreValidationError.descriptionRequired);
    }
    if (description!.length < ValidationConstants.minStoreDescriptionLength) {
      return const ValidationResult.invalid(
          StoreValidationError.descriptionTooShort);
    }
    if (description.length > ValidationConstants.maxStoreDescriptionLength) {
      return const ValidationResult.invalid(
          StoreValidationError.descriptionTooLong);
    }
    return const ValidationResult.valid();
  }

  static ValidationResult validateCountry(String? country) {
    if (!ValidatorUtils.isNotEmpty(country)) {
      return const ValidationResult.invalid(
          StoreValidationError.countryRequired);
    }
    return const ValidationResult.valid();
  }

  static ValidationResult validateCity(String? city) {
    if (!ValidatorUtils.isNotEmpty(city)) {
      return const ValidationResult.invalid(StoreValidationError.cityRequired);
    }
    return const ValidationResult.valid();
  }

  static ValidationResult validateImage(Object? image) {
    if (image == null) {
      return const ValidationResult.invalid(StoreValidationError.imageRequired);
    }
    return const ValidationResult.valid();
  }

  static ValidationResult validateCoverImage(Object? image) {
    if (image == null) {
      return const ValidationResult.invalid(
          StoreValidationError.coverImageRequired);
    }
    return const ValidationResult.valid();
  }
}
