import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'filter_widget.dart';
import 'search_filter_widget.dart';

class SearchBarWithFilter extends StatelessWidget {
  final Function() onFilterIconClicked;
  final Function(String text) onTextSubmitted;
  const SearchBarWithFilter({super.key, required this.onFilterIconClicked, required this.onTextSubmitted});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: context.theme.colors.surfaceLow,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child:
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child:
              SearchBarWidget(
                onTextSubmitted: (String text) { onTextSubmitted(text); },
              ),
            ),
          ),
        ),
        const SizedBox(width: 2),
        FilterWidget(onFilterIconClicked: onFilterIconClicked),
      ],
    );
  }
}
