import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gap/flutter_gap.dart';

export 'sellio_initial_search.dart';
export 'sellio_recent_searches.dart';
export 'sellio_search_empty_state.dart';

class SellioSearchBar extends StatefulWidget {
  final Function(String text)? onTextSubmitted;
  final TextEditingController? controller;
  final Function()? onTextFieldClicked;
  final bool isReadOnly;
  final String hintText;
  final bool isShowFilterIcon;
  final Function()? onFilterIconClicked;

  const SellioSearchBar({
    super.key,
    this.onTextSubmitted,
    this.controller,
    this.onTextFieldClicked,
    this.isReadOnly = false,
    required this.hintText,
    this.isShowFilterIcon = false,
    this.onFilterIconClicked,
  });

  @override
  State<SellioSearchBar> createState() => _SellioSearchBarState();
}

class _SellioSearchBarState extends State<SellioSearchBar> {
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
    Widget searchField = SellioTextField(
      maxLine: 1,
      fillColor: context.theme.colors.surfaceLow,
      enabledBorderRadius: 12,
      focusedBorderRadius: 12,
      errorBorderRadius: 12,
      focusedErrorBorderRadius: 12,
      cornerRadius: const BorderRadius.all(Radius.circular(12)),
      hintText: widget.hintText,
      hintStyle: context.theme.typography.textTheme.labelMedium
          .copyWith(color: context.theme.colors.body),
      prefixIcon: SvgPicture.asset(
        AppImages.search,
        width: 24,
        height: 24,
      ),
      controller: _searchController,
      readOnly: widget.isReadOnly,
      onTap: widget.onTextFieldClicked,
      onFieldSubmitted: widget.onTextSubmitted,
    );

    if (!widget.isShowFilterIcon) {
      return searchField;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SellioTextField(
              maxLine: 1,
              fillColor: context.theme.colors.surfaceLow,
              cornerRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(12),
                bottomStart: Radius.circular(12),
                topEnd: Radius.circular(0),
                bottomEnd: Radius.circular(0),
              ),
                hintText: widget.hintText,
                hintStyle: context.theme.typography.textTheme.labelMedium
                    .copyWith(color: context.theme.colors.body),
                prefixIcon: SvgPicture.asset(
                  AppImages.search,
                  width: 24,
                  height: 24,
                ),
                controller: _searchController,
                readOnly: widget.isReadOnly,
                onTap: widget.onTextFieldClicked,
                onFieldSubmitted: widget.onTextSubmitted,
              ),
            ),
          Material(
            color: context.theme.colors.primaryVariant,
            borderRadius: const BorderRadiusDirectional.only(
              topEnd: Radius.circular(12),
              bottomEnd: Radius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: widget.onFilterIconClicked,
              child: SizedBox(
                width: 48,
                child: Center(
                  child: SvgPicture.asset(
                    AppImages.filter,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

