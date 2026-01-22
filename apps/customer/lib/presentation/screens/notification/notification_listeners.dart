import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

import 'cubits/notifications/cubit/notification_cubit.dart';
import 'cubits/notifications/cubit/notification_state.dart';

class NotificationListeners extends StatelessWidget {
  final Widget child;

  const NotificationListeners({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NotificationCubit, NotificationState>(
          listener: _onNotificationStateChanged,
        ),
      ],
      child: child,
    );
  }

  void _onNotificationStateChanged(BuildContext context,
      NotificationState state) {
    if (state is NotificationError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${context.local.error_loading_notifications}: ${state.message}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
