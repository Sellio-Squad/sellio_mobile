import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../core/localization/l10n/localization_service.dart';

enum StoreValidationError implements ValidationError {
  nameRequired,
  nameTooShort,
  nameTooLong,
  descriptionRequired,
  descriptionTooShort,
  descriptionTooLong,
  countryRequired,
  cityRequired,
  imageRequired,
  coverImageRequired;

  @override
  String toLocalizedString(BuildContext context) {
    return switch (this) {
      StoreValidationError.nameRequired => context.local.store_name_required,
      StoreValidationError.nameTooShort => context.local.store_name_too_short,
      StoreValidationError.nameTooLong => context.local.store_name_too_long,
      StoreValidationError.descriptionRequired =>
        context.local.store_description_required,
      StoreValidationError.descriptionTooShort =>
        context.local.store_description_too_short,
      StoreValidationError.descriptionTooLong =>
        context.local.store_description_too_long,
      StoreValidationError.countryRequired => context.local.country_required,
      StoreValidationError.cityRequired => context.local.city_required,
      StoreValidationError.imageRequired => context.local.store_image_required,
      StoreValidationError.coverImageRequired =>
        context.local.store_cover_image_required,
    };
  }
}
