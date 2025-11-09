import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubits/user/cubit/user_cubit.dart';
import '../../../cubits/user/cubit/user_state.dart';
import '../utils/home_navigation.dart';
import '../widgets/home_app_bar.dart';

PreferredSizeWidget buildHomeAppBar(BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(68.0),
    child: BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final userName = state is UserLoaded ? state.name : 'Guest';
        final location = state is UserLoaded ? state.location : null;

        return HomeAppBar(
          userName: userName,
          location: location,
          onNotificationTap: () => navigateToNotifications(context),
        );
      },
    ),
  );
}