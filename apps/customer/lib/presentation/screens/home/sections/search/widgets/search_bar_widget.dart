import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String text) onTextSubmitted;
  final TextEditingController? controller;
  final Function()? onTextFiledClicked;
  final bool isReadOnly;

  const SearchBarWidget({
    super.key,
    required this.onTextSubmitted,
    this.controller,
    this.onTextFiledClicked,
    this.isReadOnly = false,
  });

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
    return ClipRRect(
      borderRadius: const BorderRadiusDirectional.only(
        topStart: Radius.circular(12),
        bottomStart: Radius.circular(12),
      ),
      child: SellioTextField(
        maxLine: 1,
        fillColor: context.theme.colors.surfaceLow,
        enabledBorderRadius: 0,
        focusedBorderRadius: 0,
        errorBorderRadius: 0,
        focusedErrorBorderRadius: 0,
        hintText: context.local.search_your_favorite_items,
        hintStyle: context.theme.typography.textTheme.labelMedium
            .copyWith(color: context.theme.colors.body),
        prefixIcon: SvgPicture.asset(
          AppImages.search,
          width: 24,
          height: 24,
        ),
        controller: _searchController,
        readOnly: widget.isReadOnly,
        onTap: widget.onTextFiledClicked,
      ),
    );
  }
}
