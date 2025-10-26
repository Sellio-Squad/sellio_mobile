import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SellioTextField extends StatefulWidget {
  final bool isParagraph;
  final bool showEye;

  const SellioTextField({
    super.key,
    this.isParagraph = false,
    this.showEye = true,
  });

  @override
  State<SellioTextField> createState() => _SellioTextFieldState();
}

class _SellioTextFieldState extends State<SellioTextField> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  bool isError = false;
  bool isObscured = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
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
        ? Colors.red
        : isFocused
        ? context.theme.colors.primary
        : context.theme.colors.body;

    final Color hintColor = isFocused
        ? context.theme.colors.title
        : context.theme.colors.body;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: isFocused && !isError
            ? [
                const BoxShadow(
                  color: Color(0x1F520826),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: TextField(
        focusNode: _focusNode,
        controller: _controller,
        onChanged: (value) {
          setState(() {
            isError = value.isEmpty;
          });
        },
        obscureText: isObscured,
        onEditingComplete: () {
          _focusNode.unfocus();
          setState(() {});
        },
        style: context.theme.typography.textTheme.bodyMedium.copyWith(
          color: isFocused
              ? context.theme.colors.title
              : context.theme.colors.body,
        ),
        maxLines: widget.isParagraph ? null : 1,

        decoration: InputDecoration(
          filled: true,
          fillColor: context.theme.colors.surface,
          hintText: 'Full name',
          hintStyle: context.theme.typography.textTheme.labelMedium.copyWith(
            color: hintColor,
          ),
          prefixIcon: widget.isParagraph
              ? null
              : Padding(
                  padding: const EdgeInsets.only(left: 16, right: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        Assets.user,
                        colorFilter: ColorFilter.mode(
                          iconColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      if (isError) ...[
                        const SizedBox(width: 12),
                        Container(
                          width: 1,
                          height: 30,
                          color: context.theme.colors.stroke,
                        ),
                      ],
                    ],
                  ),
                ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 24,
            minHeight: 24,
          ),

          suffixIcon: widget.isParagraph || !widget.showEye
              ? null
              : IconButton(
                  icon: SvgPicture.asset(
                    isObscured ? Assets.closeEye : Assets.openEye,
                    colorFilter: ColorFilter.mode(
                      context.theme.colors.body,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      isObscured = !isObscured;
                    });
                  },
                ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderColor, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: borderColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red),
          ),
          errorText: widget.isParagraph
              ? null
              : isError
              ? 'Error message!'
              : null,
          errorStyle: context.theme.typography.textTheme.labelSmall,
        ),
      ),
    );
  }
}
