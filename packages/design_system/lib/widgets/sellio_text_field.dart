import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../themes/sellio_theme_provider.dart';
import '../constants/app_images.dart';

class SellioTextField extends StatefulWidget {
  final bool isParagraph;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatter;
  final BorderRadiusGeometry cornerRadius;
  final TextStyle? textStyle;
  final int? maxLine;
  final bool isTextFieldFilled;
  final Color? fillColor;
  final String hintText;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry prefixIconPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double enabledBorderRadius;
  final double focusedBorderRadius;
  final double errorBorderRadius;
  final double focusedErrorBorderRadius;
  final TextStyle? errorStyle;
  final TextEditingController? controller;
  final bool isPhoneNumber;
  final String? countryFlag;
  final bool isError;
  final String? errorMessage;
  final bool readOnly;
  final VoidCallback? onTap;

  const SellioTextField({
    super.key,
    this.isParagraph = false,
    this.inputType,
    this.inputFormatter,
    this.cornerRadius = const BorderRadius.all(Radius.circular(8)),
    this.textStyle,
    this.maxLine,
    this.isTextFieldFilled = true,
    this.fillColor,
    required this.hintText,
    this.hintStyle,
    this.prefixIconPadding = const EdgeInsets.only(left: 16, right: 12),
    this.prefixIcon,
    this.suffixIcon,
    this.enabledBorderRadius = 8.0,
    this.focusedBorderRadius = 8.0,
    this.errorBorderRadius = 8.0,
    this.focusedErrorBorderRadius = 8.0,
    this.errorStyle,
    this.controller,
    this.isPhoneNumber = false,
    this.countryFlag = AppImages.flagIraq,
    this.isError = false,
    this.errorMessage,
    this.readOnly = false,
    this.onTap,
  });

  @override
  State<SellioTextField> createState() => _SellioTextFieldState();
}

class _SellioTextFieldState extends State<SellioTextField> {
  final FocusNode _focusNode = FocusNode();
  late final TextEditingController _effectiveController;

  bool isError = false;
  bool isObscured = false;

  @override
  void initState() {
    super.initState();

    _effectiveController = widget.controller ?? TextEditingController();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          isError = !widget.isError ? _effectiveController.text.isEmpty : widget.isError;
        });
      }
    });

    isObscured = widget.inputType == TextInputType.visiblePassword;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    if (widget.controller == null) {
      _effectiveController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFocused = _focusNode.hasFocus;

    final Color borderColor = isError
        ? context.theme.colors.semanticError
        : isFocused
        ? context.theme.colors.primary
        : context.theme.colors.stroke;

    final Color iconColor = isError
        ? context.theme.colors.neutralsHint
        : isFocused
        ? context.theme.colors.primary
        : context.theme.colors.body;

    final Color hintColor = isFocused
        ? context.theme.colors.title
        : context.theme.colors.body;

    final List<BoxShadow> textFieldShadow = isFocused && !isError
        ? [
            BoxShadow(
              color: context.theme.colors.shadowColor,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ]
        : [];

    final textFieldStyle =
        widget.textStyle ??
        context.theme.typography.textTheme.bodyMedium.copyWith(
          color: context.theme.colors.title,
        );

    final maxLines = widget.isParagraph
        ? (widget.maxLine ?? 5)
        : (widget.maxLine ?? 1);

    final filledColor = widget.fillColor ?? context.theme.colors.surface;

    final hintTextStyle =
        widget.hintStyle ??
        context.theme.typography.textTheme.labelMedium.copyWith(
          color: hintColor,
        );

    final String? errorText = widget.errorMessage;

    final errorStyle =
        widget.errorStyle ??
        context.theme.typography.textTheme.labelSmall.copyWith(
          color: context.theme.colors.semanticError,
        );

    return GestureDetector(
      onTap: widget.readOnly && widget.onTap != null ? widget.onTap : null,
      child: AbsorbPointer(
        absorbing: widget.readOnly,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: widget.cornerRadius,
              boxShadow: textFieldShadow,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    keyboardType: widget.inputType ?? TextInputType.text,
                    focusNode: _focusNode,
                    controller: _effectiveController,
                    inputFormatters:
                    widget.inputFormatter ??
                        [
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            final lineCount = '\n'.allMatches(newValue.text).length + 1;
                            if (lineCount > 5) {
                              return oldValue;
                            }
                            return newValue;
                          }),
                        ],

                    onChanged: (value) {
                      setState(() {
                        isError = value.isEmpty;
                      });
                    },
                    obscureText: isObscured,
                    obscuringCharacter: '●',
                    style: textFieldStyle,
                    maxLines: maxLines,
                    decoration: InputDecoration(
                      filled: widget.isTextFieldFilled,
                      fillColor: filledColor,
                      hintText: widget.hintText,
                      hintStyle: hintTextStyle,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 14, horizontal: 12),
                      prefixIcon: widget.isParagraph
                          ? null
                          : _buildPrefixIcon(iconColor, AppImages.iconsPath),
                      prefixIconConstraints: const BoxConstraints(
                        minWidth: 24,
                        minHeight: 24,
                      ),
                      suffixIcon: _buildSuffixIcon(iconColor),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(widget.enabledBorderRadius),
                        borderSide: BorderSide(color: borderColor, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(widget.focusedBorderRadius),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(widget.errorBorderRadius),
                        borderSide: BorderSide(color: context.theme.colors.semanticError),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          widget.focusedErrorBorderRadius,
                        ),
                        borderSide: BorderSide(color: context.theme.colors.semanticError),
                      ),
                      errorStyle: errorStyle,
                    ),
                  ),
                  if (isError && errorText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 4),
                      child: Text(
                        errorText,
                        style: errorStyle,
                      ),
                    ),
                ]
            )
        ),
      ),
    );
  }

  Widget? _buildPrefixIcon(Color iconColor, String icon) {
    if (widget.isParagraph) return null;

    return Padding(
      padding: widget.prefixIconPadding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.prefixIcon != null) ...[widget.prefixIcon!],
        ],
      ),
    );
  }

  Widget? _buildSuffixIcon(Color iconColor) {
    if (widget.isParagraph) return null;

    if (widget.inputType == TextInputType.visiblePassword) {
      return IconButton(
        icon: SvgPicture.asset(
          isObscured ? AppImages.closeEye : AppImages.openEye,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        ),
        onPressed: () {
          setState(() {
            isObscured = !isObscured;
          });
        },
      );
    }
    return null;
  }
}
