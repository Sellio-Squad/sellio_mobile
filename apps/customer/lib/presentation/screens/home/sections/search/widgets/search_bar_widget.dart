import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import 'filter_widget.dart';
import 'search_bar_with_filter.dart';

class SearchBarWithFilter extends StatelessWidget {
  final Function() onFilterIconClicked;
  final Function(String text) onTextSubmitted;
  final TextEditingController? controller;
  final Function()? onTextFiledClicked;
  final bool isReadOnly;

  const SearchBarWithFilter({
    super.key,
    required this.onFilterIconClicked,
    required this.onTextSubmitted,
    this.controller,
    this.onTextFiledClicked,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: context.theme.colors.surfaceLow,
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(12),
                bottomStart: Radius.circular(12),
              ),
            ),
            child:
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child:
              SearchBarWidget(
                isReadOnly: isReadOnly,
                onTextSubmitted: (String text) { onTextSubmitted(text); },
                controller: controller,
                onTextFiledClicked: onTextFiledClicked,
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
