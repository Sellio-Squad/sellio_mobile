import 'package:flutter/material.dart';
import '../utils/home_refresh_handler.dart';
import 'home_sections_builder.dart';

Widget buildHomeBody(BuildContext context, dynamic colors) {
  return Stack(
    children: [
      _buildGradientBackground(colors),
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

Widget _buildGradientBackground(dynamic colors) {
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