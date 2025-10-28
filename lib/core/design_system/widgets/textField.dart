import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SellioTextField extends StatefulWidget {
  final bool isParagraph;
  final TextInputType? inputType;
  final BorderRadiusGeometry cornerRadius;
  final Color shadowColor;
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

  const SellioTextField({
    super.key,
    this.isParagraph = false,
    this.inputType,
    this.cornerRadius = const BorderRadius.all(Radius.circular(8)),
    this.shadowColor = const Color(0x1F520826),
    this.textStyle,
    this.maxLine,
    this.isTextFieldFilled = true,
    this.fillColor,
    this.hintText = 'Full name',
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
  });
  @override
  State<SellioTextField> createState() => _SellioTextFieldState();
}

class _SellioTextFieldState extends State<SellioTextField> {
  final FocusNode _focusNode = FocusNode();
  // *** FIX 1: This will store the *actual* controller being used. ***
  late final TextEditingController _effectiveController;

  bool isError = false;
  bool isObscured = false;

  @override
  void initState() {
    super.initState();

    // *** This is the FIX ***
    // It runs right at the start and gives _effectiveController a value.
    _effectiveController = widget.controller ?? TextEditingController();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          // This now safely uses the initialized controller
          isError = _effectiveController.text.isEmpty;
        });
      }
    });

    isObscured = widget.inputType == TextInputType.visiblePassword;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    // *** FIX 4: Only dispose the controller if this widget created it. ***
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
        color: widget.shadowColor,
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ]
        : [];

    final textFieldStyle = widget.textStyle ??
        context.theme.typography.textTheme.bodyMedium.copyWith(
          color: isFocused
              ? context.theme.colors.title
              : context.theme.colors.body,
        );

    final maxLines =
    widget.isParagraph ? (widget.maxLine ?? 5) : (widget.maxLine ?? 1);

    final filledColor = widget.fillColor ?? context.theme.colors.surface;

    final hintTextStyle = widget.hintStyle ??
        context.theme.typography.textTheme.labelMedium.copyWith(
          color: hintColor,
        );

    final String? errorText =
    widget.isParagraph ? null : (isError ? 'Error message!' : null);

    final errorStyle = widget.errorStyle ??
        context.theme.typography.textTheme.labelSmall.copyWith(
          color: context.theme.colors.semanticError,
        );

    return Container(
      decoration: BoxDecoration(
        borderRadius: widget.cornerRadius,
        boxShadow: textFieldShadow,
      ),
      child: TextField(
        keyboardType: widget.inputType ?? TextInputType.text,
        focusNode: _focusNode,
        // *** FIX 5: Use the *effective* controller. ***
        controller: _effectiveController,
        inputFormatters: [
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
            // *** This check is also important ***
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
          prefixIcon: widget.isParagraph
              ? null
              : widget.prefixIcon ?? _buildPrefixIcon(iconColor),
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
          errorText: errorText,
          errorStyle: errorStyle,
        ),
      ),
    );
  }

  Widget? _buildPrefixIcon(Color iconColor) {
    if (widget.isParagraph) return null;

    return Padding(
      padding: widget.prefixIconPadding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            Assets.user,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
          if (isError) ...[
            const SizedBox(width: 12),
            Container(width: 1, height: 30, color: context.theme.colors.stroke),
          ],
        ],
      ),
    );
  }

  Widget? _buildSuffixIcon(Color iconColor) {
    if (widget.isParagraph) return null;

    if (widget.inputType == TextInputType.visiblePassword) {
      return IconButton(
        icon: SvgPicture.asset(
          isObscured ? Assets.closeEye : Assets.openEye,
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
