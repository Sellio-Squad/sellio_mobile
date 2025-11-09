import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';
import 'builders/home_sections_builder.dart';
import 'home_bloc_providers.dart';
import 'home_listeners.dart';
import 'builders/home_app_bar_builder.dart';
import 'utils/home_refresh_handler.dart';

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
          body: homeBody(context, colors),
        ),
      ),
    );
  }
}



Widget homeBody(BuildContext context, dynamic colors) {
  return Stack(
    children: [
      _gradientBackground(colors),
      SafeArea(
        child: RefreshIndicator(
          onRefresh: () => handleHomeRefresh(context),
          child: CustomScrollView(
            slivers: buildHomeSections(context),
          ),
        ),
      ),
    ],
  );
}

Widget _gradientBackground(dynamic colors) {
  return Container(
    height: 256,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          colors.primary.withOpacity(0.16),
          colors.primary.withOpacity(0.0),
        ],
      ),
    ),
  );
}