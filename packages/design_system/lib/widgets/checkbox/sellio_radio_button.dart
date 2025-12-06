import 'package:flutter/material.dart';

import '../../themes/sellio_colors.dart';

enum RadioState {
  unchecked,
  checked,
  disabled,
}

class SellioRadioButton extends StatefulWidget {
  final RadioState state;
  final ValueChanged<RadioState>? onChanged;
  final double size;

  const SellioRadioButton({
    super.key,
    required this.state,
    this.onChanged,
    this.size = 20.0,
  });

  @override
  State<SellioRadioButton> createState() => _SellioRadioButtonState();
}

class _SellioRadioButtonState extends State<SellioRadioButton> {
  @override
  Widget build(BuildContext context) {
    final bool isEnabled = widget.state != RadioState.disabled;
    final colorScheme = SellioColors.light;

    return GestureDetector(
      onTap: isEnabled && widget.onChanged != null
          ? () {
        if (widget.state == RadioState.unchecked) {
          widget.onChanged!(RadioState.checked);
        }
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
          shape: BoxShape.circle,
          boxShadow: widget.state == RadioState.checked
              ? [
            BoxShadow(
              color: colorScheme.primary.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ]
              : null,
        ),
        child: _buildInnerCircle(colorScheme),
      ),
    );
  }

  Color _getBackgroundColor(SellioColorScheme colorScheme) {
    switch (widget.state) {
      case RadioState.unchecked:
        return colorScheme.surfaceLow;
      case RadioState.checked:
        return colorScheme.primary;
      case RadioState.disabled:
        return colorScheme.disabled;
    }
  }

  Color _getBorderColor(SellioColorScheme colorScheme) {
    switch (widget.state) {
      case RadioState.unchecked:
        return colorScheme.stroke;
      case RadioState.checked:
        return colorScheme.primary;
      case RadioState.disabled:
        return colorScheme.disabled;
    }
  }

  Widget? _buildInnerCircle(SellioColorScheme colorScheme) {
    if (widget.state == RadioState.unchecked) {
      return null;
    }

    return Center(
      child: Container(
        width: widget.size * 0.4,
        height: widget.size * 0.4,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
