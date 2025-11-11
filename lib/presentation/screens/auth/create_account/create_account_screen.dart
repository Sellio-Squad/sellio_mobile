import 'package:flutter/material.dart';
import '../../../../core/design_system/themes/sellio_theme.dart';
import '../../../../core/design_system/widgets/AuthBackgroundWrapper.dart';
import 'builders/create_account_button_builder.dart';
import 'builders/create_account_form_builder.dart';
import 'create_account_bloc_providers.dart';
import 'create_account_listeners.dart';
import 'widgets/create_account_footer.dart';
import 'widgets/create_account_header.dart';

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
    final colors = SellioTheme
        .of(context)
        .colors;

    return CreateAccountListeners(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: AuthBackgroundWrapper(
          containerPadding: const EdgeInsets.symmetric(horizontal: 0),
          showLogo: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildCreateAccountHeader(context),
                    buildCreateAccountForm(context),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: colors.surfaceLow,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, -4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                height: 110,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: buildCreateAccountButton(context),
                    ),
                    const SizedBox(height: 12),
                    buildCreateAccountFooter(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}