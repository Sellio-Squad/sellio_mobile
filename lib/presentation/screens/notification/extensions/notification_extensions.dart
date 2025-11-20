import 'package:flutter/cupertino.dart';
import 'package:sellio_mobile/core/design_system/constants/app_images.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

enum NotificationStateMessage {
  placed,
  delivered,
  cancelled,
}

extension NotificationState on NotificationStateMessage {
  String localized(BuildContext context) {
    switch (this) {
      case NotificationStateMessage.placed:
        return context.local.has_been_placed_successfully;

      case NotificationStateMessage.delivered:
        return context.local.has_been_delivered_successfully;

      case NotificationStateMessage.cancelled:
        return context.local.has_been_cancelled;
    }
  }

  String get icon {
    switch (this) {
      case NotificationStateMessage.placed:
        return AppImages.packageDelivered;

      case NotificationStateMessage.delivered:
        return AppImages.packageDelivery;

      case NotificationStateMessage.cancelled:
        return AppImages.packageRemove;
    }
  }
}