import 'package:flutter/material.dart';
import 'package:sellio_mobile/presentation/screens/home/sections/search/widgets/search_bar_widget.dart';

import 'filter_widget.dart';

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
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SearchBarWidget(
              isReadOnly: isReadOnly,
              onTextSubmitted: onTextSubmitted,
              controller: controller,
              onTextFiledClicked: onTextFiledClicked,
            ),
          ),
          FilterWidget(onFilterIconClicked: onFilterIconClicked),
        ],
      ),
    );
  }
}
