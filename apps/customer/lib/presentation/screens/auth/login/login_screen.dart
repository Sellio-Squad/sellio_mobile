import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'login_bloc_providers.dart';
import 'login_listeners.dart';
import 'widgets/login_footer.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginBlocProviders(
      child: _LoginScreenContent(),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoginHeader(),
              Gap(40),
              LoginForm(),
              Gap(175),
              LoginFooter(),
              Gap(16),
            ],
            ),
        ),
      ),
    );
  }
}