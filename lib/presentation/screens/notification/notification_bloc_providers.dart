import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          create: (context) =>
          NotificationCubit()
            ..loadNotifications(),
        ),
      ],
      child: child,
    );
  }
}