import 'package:flutter/material.dart';

import '../../../../core/design_system/themes/sellio_theme_provider.dart';
import '../../../../core/design_system/widgets/AuthBackgroundWrapper.dart';
import 'builders/create_account_button_builder.dart';
import 'builders/create_account_form_builder.dart' show CreateAccountFormWidget;
import 'create_account_bloc_providers.dart';
import 'create_account_listeners.dart';
import 'widgets/create_account_footer.dart';
import 'widgets/create_account_header.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateAccountBlocProviders(
      child: CreateAccountListeners(
        child: AuthBackgroundWrapper(
          containerPadding: const EdgeInsets.all(16),
          showLogo: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildCreateAccountHeader(context),
              CreateAccountFormWidget(),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: context.theme.colors.surfaceLow,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, -2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CreateAccountButtonBuilder(),
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
