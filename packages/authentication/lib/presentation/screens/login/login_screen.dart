import 'package:core/domain/repositories/country_repository.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../cubits/auth/authentication_cubit.dart';
import '../../navigation/auth_navigator.dart';
import 'cubit/login_cubit.dart';
import 'widgets/login_body.dart';
import 'widgets/login_listeners.dart';

class LoginScreen extends StatelessWidget {
  final AuthRepository authRepository;
  final CountryRepository countryRepository;
  final AuthenticationCubit authenticationCubit;
  final AuthNavigator navigator;

  const LoginScreen({
    super.key,
    required this.authRepository,
    required this.countryRepository,
    required this.authenticationCubit,
    required this.navigator,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        authRepository: authRepository,
        countryRepository: countryRepository,
        authenticationCubit: authenticationCubit,
      )..loadInitialCountry(),
      child: _LoginScreenContent(navigator: navigator),
    );
  }
}

class _LoginScreenContent extends StatelessWidget {
  final AuthNavigator navigator;

  const _LoginScreenContent({required this.navigator});

  @override
  Widget build(BuildContext context) {
    return LoginListeners(
      navigator: navigator,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: AuthBackgroundWrapper(
          showLogo: true,
          child: LoginBody(navigator: navigator),
        ),
      ),
    );
  }
}
