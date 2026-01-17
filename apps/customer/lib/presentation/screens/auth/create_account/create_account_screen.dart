import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/design_system.dart';
import '../../../../di/injection_container.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../../../../domain/repositories/country_repository.dart';
import 'cubit/registration_cubit.dart';
import 'create_account_listeners.dart';
import 'widgets/create_account_body.dart';
import 'package:country_picker/country_picker.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Country>(
      future: sl<CountryRepository>().getInitialCountry(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final initialCountry = snapshot.data!;

        return BlocProvider(
          create: (context) => RegistrationCubit(
            authRepository: sl<AuthRepository>(),
            initialCountry: initialCountry,
          ),
          child: const _CreateAccountScreenContent(),
        );
      },
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
