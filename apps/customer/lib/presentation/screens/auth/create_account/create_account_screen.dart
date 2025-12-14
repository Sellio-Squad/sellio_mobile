import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'builders/create_account_sections_builder.dart';
import 'create_account_bloc_providers.dart';
import 'create_account_listeners.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CreateAccountBlocProviders(
      child: _CreateAccountScreenContent(),
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