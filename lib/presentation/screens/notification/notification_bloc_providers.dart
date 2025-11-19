import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection_container.dart';
import 'cubits/notifications/cubit/notification_cubit.dart';

class NotificationBlocProviders extends StatelessWidget {
  final Widget child;

  const NotificationBlocProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<NotificationCubit>()..loadNotifications(),
        ),
      ],
      child: child,
    );
  }
}