import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';
import 'home_bloc_providers.dart';
import 'home_listeners.dart';
import 'builders/home_app_bar_builder.dart';
import 'builders/home_body_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeBlocProviders(
      child: _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatelessWidget {
  const _HomeScreenContent();

  @override
  Widget build(BuildContext context) {
    final colors = SellioTheme.of(context).colors;

    return HomeListeners(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: buildHomeAppBar(context),
          extendBodyBehindAppBar: true,
          backgroundColor: colors.surfaceLow,
          body: buildHomeBody(context, colors),
        ),
      ),
    );
  }
}