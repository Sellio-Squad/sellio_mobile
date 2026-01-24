import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/design_system.dart';
import '../../../../di/injection_container.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../../../../domain/repositories/country_repository.dart';
import 'cubit/login_cubit.dart';
import 'login_listeners.dart';
import 'widgets/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        authRepository: sl<AuthRepository>(),
        countryRepository: sl<CountryRepository>(),
      )..loadInitialCountry(),
      child: const _LoginScreenContent(),
    );
  }
}

class _LoginScreenContent extends StatelessWidget {
  const _LoginScreenContent();

  @override
  Widget build(BuildContext context) {
    return LoginListeners(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: AuthBackgroundWrapper(
          showLogo: true,
          child: const LoginBody(),
        ),
      ),
    );
  }
}
