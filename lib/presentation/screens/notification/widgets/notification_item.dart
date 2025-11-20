import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/presentation/screens/notification/extensions/notification_extensions.dart';
import '../../../../core/design_system/constants/app_images.dart';
import '../cubits/notifications/cubit/notification_cubit.dart';
import '../models/notification_model.dart';
import '../utils/notification_utils.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final type = NotificationUtils.getMessageType(notification.state);

    final icon = type.icon;
    final orderState = type.localized(context);

    return Dismissible(
      key: Key(notification.orderId),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.read<NotificationCubit>().deleteNotification(
            notification.orderId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.local.notification_dismissed),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          context.read<NotificationCubit>().markAsRead(notification.orderId);
        },
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.theme.colors.surface,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(9),
                      child: SvgPicture.asset(
                        icon,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          context.theme.colors.title,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 8, right: 16, bottom: 2),
                        child: Text.rich(
                          TextSpan(
                            text: context.local.your_order_from(notification.orderId),
                            style: context.theme.typography.textTheme.bodySmall
                                .copyWith(
                              color: context.theme.colors.body,
                            ),
                            children: [
                              TextSpan(
                                text: notification.storeName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Rubik',
                                ),
                              ),
                              TextSpan(
                                text: " $orderState.",
                                style: context.theme.typography.textTheme
                                    .bodySmall
                                    .copyWith(
                                  color: context.theme.colors.body,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          notification.time,
                          style: context.theme.typography.textTheme.labelSmall
                              .copyWith(
                            color: context.theme.colors.body,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Divider(
                color: context.theme.colors.stroke,
                thickness: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}