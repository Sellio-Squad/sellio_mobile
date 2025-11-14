import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/notifications/cubit/notification_cubit.dart';
import '../cubits/notifications/cubit/notification_state.dart';
import '../widgets/notification_content.dart';
import '../widgets/notification_empty_state.dart';
import '../widgets/notification_error_state.dart';
import '../widgets/notification_loading_state.dart';

Widget buildNotificationSections(BuildContext context) {
  return BlocBuilder<NotificationCubit, NotificationState>(
    builder: (context, state) {
      return switch (state) {
        NotificationInitial() => const NotificationLoadingState(),
        NotificationLoading() => const NotificationLoadingState(),
        NotificationLoaded() => state.allNotifications.isEmpty
            ? const NotificationEmptyState()
            : NotificationContent(
                groupedNotifications: state.groupedNotifications,
                onRefresh: () =>
                    context.read<NotificationCubit>().refreshNotifications(),
              ),
        NotificationError() => NotificationErrorState(
            message: state.message,
            onRetry: () =>
                context.read<NotificationCubit>().loadNotifications(),
          ),
      };
    },
  );
}
