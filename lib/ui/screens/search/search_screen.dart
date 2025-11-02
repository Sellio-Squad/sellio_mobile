import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/constants/app_strings.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SellioAppBar(
        title: AppStrings.search,
        showBackButton: true,
      ),
      body: Center(
        child: Text(
          'Search Screen',
          style: context.theme.typography.textTheme.headlineLarge.copyWith(
            color: context.theme.colors.primary,
          ),
        ),
      ),
    );
  }
}
