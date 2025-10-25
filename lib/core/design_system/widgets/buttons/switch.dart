import 'package:flutter/material.dart';
import '../../themes/sellio_colors.dart';

class DesignSwitch extends StatefulWidget {
  final bool value;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  const DesignSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  State<DesignSwitch> createState() => _DesignSwitchState();
}

class _DesignSwitchState extends State<DesignSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: widget.value ? 1.0 : 0.0,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void didUpdateWidget(DesignSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      widget.value ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = SellioColors.light;

    final onColor = colors.primary;
    final offColor = colors.surfaceLow;
    final disabledColor = colors.disabled;

    final thumbOn = colors.primaryVariant;
    final thumbOff = colors.hint;
    final thumbDisabled = colors.hint;
    final borderColor = colors.surfaceHigh;

    return GestureDetector(
      onTap: widget.enabled ? () => widget.onChanged(!widget.value) : null,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            width: 52,
            height: 32,
            decoration: BoxDecoration(
              color: widget.enabled
                  ? (widget.value ? onColor : offColor)
                  : disabledColor,
              borderRadius: BorderRadius.circular(100),
              border: !widget.enabled || !widget.value
                  ? Border.all(
                color: widget.enabled
                    ? borderColor
                    : disabledColor,
                width: 2,
              )
                  : null,
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  top: widget.enabled
                      ? 4.0
                      : 8.0,
                  left: widget.enabled
                      ? (widget.value ? 24.0 : 4.0)
                      : 8.0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    width: widget.enabled ? 24.0 : 16.0,
                    height: widget.enabled
                        ? (widget.value ? 24.0 : 20.0)
                        : 16.0,
                    decoration: BoxDecoration(
                      color: widget.enabled
                          ? (widget.value ? thumbOn : thumbOff)
                          : thumbDisabled,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}