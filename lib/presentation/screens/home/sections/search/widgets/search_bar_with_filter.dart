import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

import '../../../../../../core/design_system/constants/app_icons.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String text) onTextSubmitted;
  final TextEditingController? controller;

  const SearchBarWidget(
      {super.key, required this.onTextSubmitted, this.controller});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _searchController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: SvgPicture.asset(
            AppIcons.search,
            width: 24,
            height: 24,
          ),
        ),
        Expanded(
          child: TextField(
            maxLines: 1,
            cursorColor: context.theme.colors.primary,
            controller: _searchController,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              widget.onTextSubmitted(value);
            },
            decoration: InputDecoration(
              hintText: context.local.search_your_favorite_items,
              counterText: '',
              hintStyle: context.theme.typography.textTheme.labelXSmall
                  .copyWith(color: context.theme.colors.body),
              border: InputBorder.none,
            ),
            style: context.theme.typography.textTheme.labelSmall.copyWith(
              color: context.theme.colors.title,
            ),
          ),
        ),
      ],
    );
  }
}
