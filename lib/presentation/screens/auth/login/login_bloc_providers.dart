import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/di/injection_container.dart';

import 'cubits/form/login_form_cubit.dart';

class LoginBlocProviders extends StatelessWidget {
  final Widget child;

  const LoginBlocProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginFormCubit(
            authRepository: sl(),
            countryService: sl(),
          ),
        ),
      ],
      child: child,
    );
  }
}