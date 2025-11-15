import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

class SellioIndicator extends StatelessWidget {
  final int pages;
  final int currentPage;

  const SellioIndicator({
    super.key,
    required this.pages,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pages,
            (index) {
          final bool isActive = index == currentPage;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 2),
            width: isActive ? 6 : 4,
            height: isActive ? 6 : 4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? colors.secondary
                  : colors.stroke,
            ),
          );
        },
      ),
    );
  }
}
