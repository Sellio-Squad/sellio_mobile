import 'package:core/domain/repositories/country_repository.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../navigation/auth_navigator.dart';
import 'cubit/registration_cubit.dart';
import 'widgets/create_account_body.dart';
import 'widgets/create_account_listeners.dart';

class CreateAccountScreen extends StatelessWidget {
  final AuthRepository authRepository;
  final CountryRepository countryRepository;
  final AuthNavigator navigator;

  const CreateAccountScreen({
    super.key,
    required this.authRepository,
    required this.countryRepository,
    required this.navigator,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationCubit(
        authRepository: authRepository,
        countryRepository: countryRepository,
      )..loadInitialCountry(),
      child: _CreateAccountScreenContent(navigator: navigator),
    );
  }
}

class _CreateAccountScreenContent extends StatelessWidget {
  final AuthNavigator navigator;

  const _CreateAccountScreenContent({required this.navigator});

  @override
  Widget build(BuildContext context) {
    return CreateAccountListeners(
      navigator: navigator,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: AuthBackgroundWrapper(
          showLogo: false,
          child: CreateAccountBody(navigator: navigator),
        ),
      ),
    );
  }
}
