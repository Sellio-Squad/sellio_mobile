import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String text) onTextSubmitted;
  final TextEditingController? controller;
  final Function()? onTextFiledClicked;
  final bool isReadOnly;

  const SearchBarWidget(
      {super.key, required this.onTextSubmitted, this.controller , this.onTextFiledClicked , this.isReadOnly = false});

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 8),
          child: SvgPicture.asset(
            AppImages.search,
            width: 24,
            height: 24,
          ),
        ),
        Expanded(
          child: TextField(
            maxLines: 1,
            readOnly: widget.isReadOnly,
            onTap: widget.onTextFiledClicked,
            cursorColor: context.theme.colors.primary,
            controller: _searchController,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              widget.onTextSubmitted(value);
            },
            decoration: InputDecoration(
              hintText: context.local.search_your_favorite_items,
              counterText: '',
              hintStyle: context.theme.typography.textTheme.labelMedium
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
