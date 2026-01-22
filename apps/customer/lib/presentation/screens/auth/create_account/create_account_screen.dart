import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/domain/repositories/country_repository.dart';
import '../../../../di/injection_container.dart';
import '../../../../domain/repositories/auth_repository.dart';
import 'cubit/registration_cubit.dart';
import 'create_account_listeners.dart';
import 'widgets/create_account_body.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationCubit(
        authRepository: sl<AuthRepository>(),
        countryRepository: sl<CountryRepository>(),
      )..loadInitialCountry(),
      child: const _CreateAccountScreenContent(),
    );
  }
}

class _CreateAccountScreenContent extends StatelessWidget {
  const _CreateAccountScreenContent();

  @override
  Widget build(BuildContext context) {
    return CreateAccountListeners(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: AuthBackgroundWrapper(
          containerPadding: const EdgeInsets.symmetric(vertical: 16),
          showLogo: true,
          child: const CreateAccountBody(),
        ),
      ),
    );
  }
}
