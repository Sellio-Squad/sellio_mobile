import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';

import '../../themes/sellio_colors.dart';

enum CheckboxState {
  unchecked,
  checked,
  indeterminate,
  disabledChecked,
}

class CustomCheckbox extends StatefulWidget {
  final CheckboxState state;
  final ValueChanged<CheckboxState>? onChanged;
  final double size;

  const CustomCheckbox({
    super.key,
    required this.state,
    this.onChanged,
    this.size = 20.0,
  });

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    final bool isEnabled = widget.state != CheckboxState.disabledChecked;
    final colorScheme = SellioColors.light;

    return GestureDetector(
      onTap: isEnabled && widget.onChanged != null
          ? () {
        CheckboxState newState;
        switch (widget.state) {
          case CheckboxState.unchecked:
            newState = CheckboxState.checked;
            break;
          case CheckboxState.checked:
            newState = CheckboxState.unchecked;
            break;
          case CheckboxState.indeterminate:
            newState = CheckboxState.checked;
            break;
          case CheckboxState.disabledChecked:
            return;
        }
        widget.onChanged!(newState);
      }
          : null,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: _getBackgroundColor(colorScheme),
          border: Border.all(
            color: _getBorderColor(colorScheme),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: widget.state == CheckboxState.checked
              ? [
            BoxShadow(
              color: colorScheme.primary.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ]
              : null,
        ),
        child: _buildIcon(colorScheme),
      ),
    );
  }

  Color _getBackgroundColor(SellioColorScheme colorScheme) {
    switch (widget.state) {
      case CheckboxState.unchecked:
        return colorScheme.surfaceLow;
      case CheckboxState.checked:
        return colorScheme.primary;
      case CheckboxState.indeterminate:
        return colorScheme.primary;
      case CheckboxState.disabledChecked:
        return colorScheme.disabled;
    }
  }

  Color _getBorderColor(SellioColorScheme colorScheme) {
    switch (widget.state) {
      case CheckboxState.unchecked:
        return colorScheme.stroke;
      case CheckboxState.checked:
        return colorScheme.primary;
      case CheckboxState.indeterminate:
        return colorScheme.primary;
      case CheckboxState.disabledChecked:
        return colorScheme.stroke;
    }
  }

  Widget? _buildIcon(SellioColorScheme colorScheme) {
    switch (widget.state) {
      case CheckboxState.unchecked:
        return null;
      case CheckboxState.checked:
        return SvgPicture.asset(
          Assets.check,
          colorFilter: ColorFilter.mode(
            colorScheme.onPrimary,
            BlendMode.srcIn,
          ),
          width: 10.0,
          height: 10.0,
          fit: BoxFit.scaleDown,
        );
      case CheckboxState.indeterminate:
        return SvgPicture.asset(
          Assets.indeterminate,
          colorFilter: ColorFilter.mode(
            colorScheme.onPrimary,
            BlendMode.srcIn,
          ),
          width: 10.0,
          height: 10.0,
          fit: BoxFit.scaleDown,
        );
      case CheckboxState.disabledChecked:
        return SvgPicture.asset(
          Assets.check,
          colorFilter: ColorFilter.mode(
            colorScheme.hint,
            BlendMode.srcIn,
          ),
          width: 10.0,
          height: 10.0,
          fit: BoxFit.scaleDown,
        );
    }
  }
}
