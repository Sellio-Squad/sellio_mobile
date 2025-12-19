import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/design_system.dart';
import '../../../../di/injection_container.dart';
import '../../../../domain/repositories/auth_repository.dart';
import 'builders/create_account_sections_builder.dart';
import 'cubits/form/create_account_form_cubit.dart';
import 'create_account_listeners.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateAccountFormCubit(
        authRepository: sl<AuthRepository>(),
      ),
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
          child: buildCreateAccountContent(context),
        ),
      ),
    );
  }
}
