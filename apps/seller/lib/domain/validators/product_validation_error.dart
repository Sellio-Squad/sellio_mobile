import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../core/localization/l10n/localization_service.dart';

enum ProductValidationError implements ValidationError {
  titleRequired,
  descriptionRequired,
  imageRequired,
  priceInvalid,
  categoryRequired;

  @override
  String toLocalizedString(BuildContext context) {
    return switch (this) {
      ProductValidationError.titleRequired =>
        context.local.product_title_required,
      ProductValidationError.descriptionRequired =>
        context.local.product_description_required,
      ProductValidationError.imageRequired =>
        context.local.product_image_required,
      ProductValidationError.priceInvalid =>
        context.local.product_price_invalid,
      ProductValidationError.categoryRequired =>
        context.local.product_category_required,
    };
  }
}
